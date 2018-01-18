require 'spec_helper'

RSpec.describe PJBank::Recebimento::Cartao do
  let(:credencial) { "921803d24bb2da2eaebb95c96eae1dc2fd14797d" }
  let(:chave)      { "108f8607a4d0db927a605e45254851a8d5a38e37" }

  let(:http) { PJBank::Http.new(credencial: credencial, chave: chave) }

  subject { described_class.new(http) }

  describe "#credenciamento" do
    let(:http) { PJBank::Http.new }

    let(:dados) do
      {
        nome_empresa:    "Cartão Sem Conta Digital",
        conta_repasse:   "99999-9",
        agencia_repasse: "00001",
        banco_repasse:   "001",
        cnpj:            "67733092000190",
        ddd:             "22",
        telefone:        "988225511",
        email:           "pjbank-ruby-sdk@mailinator.com"
      }
    end

    context "when success" do
      it "returns the object with correct data" do
        VCR.use_cassette("recebimento/cartao/credenciamento/sucesso") do
          response = subject.credenciamento(dados)
          expect(response.status).to eql("201")
          expect(response.credencial).to_not be_nil
          expect(response.chave).to_not be_nil
        end
      end
    end

    context "when failure" do
      context "when validation error (400)" do
        before { dados[:cnpj] = "" }

        it "raises PJBank::RequestError" do
          VCR.use_cassette("recebimento/cartao/credenciamento/erro_400") do
            expect { subject.credenciamento(dados) }.to raise_error do |error|
              expect(error).to be_a(PJBank::RequestError)
              expect(error.message).to eql("CNPJ inválido.")
              expect(error.code).to eql(400)
            end
          end
        end
      end
    end
  end

  describe "#tokenizar" do
    let(:dados) do
      {
        nome_cartao:    "Fulano da silva",
        numero_cartao:  "4318148832046011",
        mes_vencimento: "01",
        ano_vencimento: "2019",
        codigo_cvv:     "155",
        cpf_cartao:     "12345678909",
        email_cartao:   "pjbank-ruby-sdk@mailinator.com",
        celular_cartao: "988225511",
      }
    end

    context "when success" do
      it "returns the object with correct data" do
        VCR.use_cassette("recebimento/cartao/tokenizar/sucesso") do
          response = subject.tokenizar(dados)
          expect(response.status).to eql("201")
          expect(response.token_cartao).to_not be_nil
        end
      end
    end

    context "when failure" do
      it "raises PJBank::RequestError" do
        VCR.use_cassette("recebimento/cartao/tokenizar/error") do
          expect { subject.tokenizar({}) }.to raise_error do |error|
            expect(error).to be_a(PJBank::RequestError)
            expect(error.message).to eql("Cartão inválido.")
            expect(error.code).to eql(400)
          end
        end
      end
    end
  end

  describe "#emitir" do
    context "when using token" do
      let(:dados) do
        {
          token_cartao:        "9c87d346e54aada76f3751ae9f686bd01c65839c",
          valor:               "10",
          parcelas:            "2",
          descricao_pagamento: "Pagamento de teste",
        }
      end

      context "when success" do
        # TODO: aguardar liberarem a credencial de cartão para poder rodar os testes
        xit "returns the object with correct data" do
          VCR.use_cassette("recebimento/cartao/emitir/com_token/sucesso") do
            response = subject.emitir(dados)
            expect(response.status).to eql("201")
            expect(response.tid).to_not be_nil
          end
        end
      end

      context "when failure" do
        # TODO: aguardar liberarem a credencial de cartão para poder rodar os testes
        context "when validation error" do
          xit "raises PJBank::RequestError" do
            dados[:valor] = ""

            VCR.use_cassette("recebimento/cartao/emitir/com_token/erro_400") do
              expect { subject.emitir(dados) }.to raise_error do |error|
                expect(error).to be_a(PJBank::RequestError)
                expect(error.message).to eql("TODO")
                expect(error.code).to eql(400)
              end
            end
          end
        end

        context "when credentia is no available yet" do
          xit "raises PJBank::RequestError" do
            # É necessária uma usar uma credencial ainda não liberada para simular esse erro
            VCR.use_cassette("recebimento/cartao/emitir/com_token/erro_406") do
              expect { subject.emitir(dados) }.to raise_error do |error|
                pending("Na verdade está sendo retornado o status http 200, mas deveria ser 406. Aguardando posição do suporte")
                expect(error).to be_a(PJBank::RequestError)
                expect(error.message).to eql("Conta de cartão está pendente de aprovação. Nossa equipe está avaliando o cadastro e lhe notificará quando o processo estiver finalizado.")
                expect(error.code).to eql(406)
                fail
              end
            end
          end
        end
      end
    end

    context "when using credit card info" do
      let(:dados) do
        {
          numero_cartao:       "4012001037141112",
          nome_cartao:         "Fulana da Silva",
          mes_vencimento:      "05",
          ano_vencimento:      "2018",
          codigo_cvv:          "123",
          cpf_cartao:          "37843514171",
          email_cartao:        "pjbank-ruby-sdk@mailinator.com",
          celular_cartao:      "1187906534",
          valor:               "10",
          parcelas:            "2",
          descricao_pagamento: "Pagamento de teste"
        }
      end

      # TODO: aguardar liberarem a credencial de cartão para poder rodar os testes
      context "when success" do
        xit "returns the object with correct data" do
          VCR.use_cassette("recebimento/cartao/emitir/com_cartao/sucesso") do
            response = subject.emitir(dados)
            expect(response.status).to eql("201")
            expect(response.tid).to_not be_nil
          end
        end
      end

      # TODO: aguardar liberarem a credencial de cartão para poder rodar os testes
      context "when failure" do
        before { dados[:valor] = "" }

        xit "raises PJBank::RequestError" do
          VCR.use_cassette("recebimento/cartao/emitir/com_cartao/erro") do
            expect { subject.emitir(dados) }.to raise_error do |error|
              expect(error).to be_a(PJBank::RequestError)
              expect(error.message).to eql("TODO")
              expect(error.code).to eql(400)
            end
          end
        end
      end
    end
  end

  describe "#cancelar" do
    # TODO: aguardar liberarem a credencial de cartão para poder rodar os testes
    context "when success" do
      xit "returns the object with correct data" do
        VCR.use_cassette("recebimento/cartao/cancelar/sucesso") do
          response = subject.cancelar("2017000006910011775476")
          expect(response.status).to eql("200")
        end
      end
    end

    # TODO: aguardar liberarem a credencial de cartão para poder rodar os testes
    context "when failure" do
      xit "raises PJBank::RequestError" do
        VCR.use_cassette("recebimento/cartao/cancelar/error") do
          expect { subject.cancelar("") }.to raise_error do |error|
            expect(error).to be_a(PJBank::RequestError)
            expect(error.message).to eql("TODO")
            expect(error.code).to eql(400)
          end
        end
      end
    end
  end

  describe "#transacoes" do
    # TODO: aguardar liberarem a credencial de cartão para poder rodar os testes
    xit "returns all the transactions an array of objects" do
      VCR.use_cassette("recebimento/cartao/transacoes/sem_filtro") do
        resposta = subject.transacoes
        expect(resposta).to be_an(Array)
        expect(resposta.first).to be_an(OpenStruct)
      end
    end

    context "when TODO: fazer um teste para cada grupo de filtros (sem filtro, efetivado, por data, paginado) e outro passando vários juntos" do
      it "TODO" do
        VCR.use_cassette("recebimento/cartao/transacoes/x") do
          pending("TODO")
          fail
        end
      end
    end
  end
end
