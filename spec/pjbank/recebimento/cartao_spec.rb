require 'spec_helper'

RSpec.describe PJBank::Recebimento::Cartao do
  # Credenciais para testes em ambiente de produção
  let(:credencial) { "1264e7bea04bb1c24b07ace759f64a1bd65c8560" }
  let(:chave)      { "ef947cf5867488f744b82744dd3a8fc4852e529f" }

  let(:http) { PJBank::Http.new(credencial: credencial, chave: chave) }

  subject { described_class.new(http) }

  # Estamos usando o ambiente de produção para fazer os testes de cartão porque é como está instruído na documentação da
  # API (https://docs.pjbank.com.br/#80a47dce-f30f-f502-cde8-5ee829e42279). Apenas os testes de credenciamento estão
  # sendo feitos no ambiente de sandbox.
  before(:each) { PJBank.configuracao.env = "production" }

  describe "#credenciamento" do
    before(:each) { PJBank.configuracao.env = "sandbox" }

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
        numero_cartao:  "4012001037141112",
        mes_vencimento: "05",
        ano_vencimento: "2018",
        codigo_cvv:     "123",
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
          token_cartao:        "26357b6566b2dce3217701ec9f3215ffd30e2324",
          valor:               "10",
          parcelas:            "2",
          descricao_pagamento: "Pagamento de teste",
        }
      end

      context "when success" do
        it "returns the object with correct data" do
          VCR.use_cassette("recebimento/cartao/emitir/com_token/sucesso") do
            response = subject.emitir(dados)
            expect(response.status).to eql("201")
            expect(response.tid).to_not be_nil
          end
        end
      end

      context "when failure" do
        context "when validation error" do
          it "raises PJBank::RequestError" do
            dados[:valor] = ""

            VCR.use_cassette("recebimento/cartao/emitir/com_token/erro_400") do
              expect { subject.emitir(dados) }.to raise_error do |error|
                expect(error).to be_a(PJBank::RequestError)
                expect(error.message).to eql("Valor inválido")
                expect(error.code).to eql(400)
              end
            end
          end
        end

        context "when credential is no available yet" do
          before(:each) { PJBank.configuracao.env = "sandbox" }

          let(:credencial) { "095136aa2f624d56493cbe5b0787132ec3391dfc" }
          let(:chave)      { "dc2a4de4531fc970a2161d38cf3a20650d02c908" }

          it "raises PJBank::RequestError" do
            # É necessária uma usar uma credencial ainda não liberada para simular esse erro
            VCR.use_cassette("recebimento/cartao/emitir/com_token/erro_400_credencial") do
              expect { subject.emitir(dados) }.to raise_error do |error|
                expect(error).to be_a(PJBank::RequestError)
                expect(error.message).to eql("Token do cliente não encontrado.")
                expect(error.code).to eql(400)
              end
            end
          end
        end
      end
    end

    context "when using credit card info" do
      let(:dados) do
        {
          numero_cartao:       "5453010000066167",
          nome_cartao:         "Fulana da Silva",
          mes_vencimento:      "05",
          ano_vencimento:      "2018",
          codigo_cvv:          "123",
          cpf_cartao:          "12345678909",
          email_cartao:        "pjbank-ruby-sdk@mailinator.com",
          celular_cartao:      "22988552211",
          valor:               "10",
          parcelas:            "2",
          descricao_pagamento: "Pagamento de teste"
        }
      end

      context "when success" do
        it "returns the object with correct data" do
          VCR.use_cassette("recebimento/cartao/emitir/com_cartao/sucesso") do
            response = subject.emitir(dados)
            expect(response.status).to eql("201")
            expect(response.tid).to_not be_nil
          end
        end
      end

      context "when failure" do
        before { dados[:valor] = "" }

        it "raises PJBank::RequestError" do
          VCR.use_cassette("recebimento/cartao/emitir/com_cartao/erro") do
            expect { subject.emitir(dados) }.to raise_error do |error|
              expect(error).to be_a(PJBank::RequestError)
              expect(error.message).to eql("Valor inválido")
              expect(error.code).to eql(400)
            end
          end
        end
      end
    end
  end

  describe "#cancelar" do
    context "when success" do
      it "returns the object with correct data" do
        VCR.use_cassette("recebimento/cartao/cancelar/sucesso") do
          response = subject.cancelar("2018000006910016943258")
          expect(response.status).to eql("200")
        end
      end
    end

    context "when failure" do
      it "raises PJBank::RequestError" do
        VCR.use_cassette("recebimento/cartao/cancelar/error") do
          expect { subject.cancelar("") }.to raise_error do |error|
            expect(error).to be_a(PJBank::RequestError)
            expect(error.message).to eql("Missing Authentication Token")
            expect(error.code).to eql(403)
          end
        end
      end
    end
  end

  describe "#transacoes" do
    it "returns all the transactions an array of objects" do
      VCR.use_cassette("recebimento/cartao/transacoes/sem_filtro") do
        resposta = subject.transacoes
        expect(resposta).to be_an(Array)
        expect(resposta.first).to be_an(OpenStruct)
      end
    end

    it "returns all the transactions an array of objects" do
      VCR.use_cassette("recebimento/cartao/transacoes/filtro_pagina_1") do
        resposta = subject.transacoes(data_inicio: "08/20/2017", data_fim: "08/20/2017", pago: 1)
        expect(resposta).to be_an(Array)
        expect(resposta.first).to be_an(OpenStruct)
        expect(resposta.size).to eql(8)
      end

      VCR.use_cassette("recebimento/cartao/transacoes/filtro_pagina_2") do
        resposta = subject.transacoes(data_inicio: "08/20/2017", data_fim: "08/20/2017", pago: 1, pagina: 2)
        expect(resposta).to be_an(Array)
        expect(resposta).to be_empty
      end
    end
  end
end
