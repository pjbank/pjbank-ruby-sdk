require 'spec_helper'

RSpec.describe PJBank::Recebimento::Cartao do
  let(:credencial) { "1264e7bea04bb1c24b07ace759f64a1bd65c8560" }
  let(:chave)      { "ef947cf5867488f744b82744dd3a8fc4852e529f" }

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

    # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
    context "when success" do
      xit "returns the object with correct data" do
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

        # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
        xit "raises PJBank::RequestError" do
          VCR.use_cassette("recebimento/cartao/credenciamento/erro_400") do
            expect { subject.credenciamento(dados) }.to raise_error do |error|
              expect(error).to be_a(PJBank::RequestError)
              expect(error.message).to eql("CPF/CNPJ inválido.")
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

    # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
    context "when success" do
      xit "returns the object with correct data" do
        VCR.use_cassette("recebimento/cartao/tokenizar/sucesso") do
          response = subject.tokenizar(dados)
          expect(response.status).to eql("201")
          expect(response.token_cartao).to_not be_nil
        end
      end
    end

    # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
    context "when failure" do
      before { dados[:numero_catao] = "" }

      xit "raises PJBank::RequestError" do
        VCR.use_cassette("recebimento/cartao/tokenizar/error") do
          expect { subject.tokenizar(dados) }.to raise_error do |error|
            expect(error).to be_a(PJBank::RequestError)
            expect(error.message).to eql("TODO")
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
          token_cartao:        "a8acb8de818d428844fee52a48ea3b075d8c9f0e",
          valor:               "10",
          parcelas:            "2",
          descricao_pagamento: "Pagamento de teste",
        }
      end

      # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
      context "when success" do
        xit "returns the object with correct data" do
          VCR.use_cassette("recebimento/cartao/emitir/com_token/sucesso") do
            response = subject.emitir(dados)
            expect(response.status).to eql("201")
            expect(response.tid).to_not be_nil
          end
        end
      end

      # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
      context "when failure" do
        before { dados[:valor] = "" }

        xit "raises PJBank::RequestError" do
          VCR.use_cassette("recebimento/cartao/emitir/com_token/erro") do
            expect { subject.emitir(dados) }.to raise_error do |error|
              expect(error).to be_a(PJBank::RequestError)
              expect(error.message).to eql("TODO")
              expect(error.code).to eql(400)
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

      # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
      context "when success" do
        xit "returns the object with correct data" do
          VCR.use_cassette("recebimento/cartao/emitir/com_cartao/sucesso") do
            response = subject.emitir(dados)
            expect(response.status).to eql("201")
            expect(response.tid).to_not be_nil
          end
        end
      end

      # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
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
    # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
    context "when success" do
      xit "returns the object with correct data" do
        VCR.use_cassette("recebimento/cartao/cancelar/sucesso") do
          response = subject.cancelar("2017000006910011775476")
          expect(response.status).to eql("200")
        end
      end
    end

    # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
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
end
