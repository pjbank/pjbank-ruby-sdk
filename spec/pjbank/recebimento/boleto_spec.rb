require 'spec_helper'

RSpec.describe PJBank::Recebimento::Boleto do
  let(:credencial) { "15524442a57788c4f3109c939056d821302155a9" }
  let(:chave)      { "027e30fbc768931e0682479e0f0404a0fcc8886b" }

  let(:http) { PJBank::Http.new(credencial: credencial, chave: chave) }

  subject { described_class.new(http) }

  describe "#credenciamento" do
    let(:http) { PJBank::Http.new }

    context "when success" do
      let(:dados) do
        {
          nome_empresa:    "Boleto Sem Conta Digital",
          conta_repasse:   "99999-9",
          agencia_repasse: "00001",
          banco_repasse:   "001",
          cnpj:            "67733092000190",
          ddd:             "22",
          telefone:        "988225511",
          email:           "pjbank-ruby-sdk@mailinator.com"
        }
      end

      it "returns the object with correct data" do
        VCR.use_cassette("recebimento/boleto/credenciamento/sucesso") do
          response = subject.credenciamento(dados)
          expect(response.status).to eql("201")
          expect(response.credencial).to_not be_nil
          expect(response.chave).to_not be_nil
        end
      end
    end

    context "when failure" do
      it "TODO" do
        pending("TODO")
        fail
      end
    end
  end

  describe "#emitir" do
    context "when success" do
      let(:dados) do
        {
          vencimento:          "12/30/2019",
          valor:               "1000.98",
          juros:               "0.0",
          multa:               "0.98",
          desconto:            "9.58",
          nome_cliente:        "Cliente de exemplo",
          cpf_cliente:         "62936576000112",
          endereco_cliente:    "Rua Joaquim Vilac",
          numero_cliente:      509,
          complemento_cliente: "",
          bairro_cliente:      "Vila Teixeira",
          cidade_cliente:      "Campinas",
          estado_cliente:      "SP",
          cep_cliente:         "13301510",
          logo_url:            "http://wallpapercave.com/wp/xK64fR4.jpg",
          texto:               "",
          grupo:               "Boletos001",
          pedido_numero:       "8972"
        }
      end

      # TODO: entrar em contato com o suporte para saber porque está dando erro 500
      it "returns the object with correct data" do
        VCR.use_cassette("recebimento/boleto/emitir/sucesso") do
          response = subject.emitir(dados)
          expect(response.status).to eql("201")
        end
      end
    end

    context "when failure" do
      it "TODO" do
        pending("TODO")
        fail
      end
    end
  end
end
