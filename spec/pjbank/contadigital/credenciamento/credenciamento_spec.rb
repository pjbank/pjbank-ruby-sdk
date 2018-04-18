require 'spec_helper'

RSpec.describe PJBank::Contadigital::Credenciamento::Credenciamento do
  subject { described_class.new(http) }

  describe "#credenciamento" do
    let(:http) { PJBank::Http.new }

    let(:dados) do
      {
        nome_empresa: "Boleto Sem Conta Digital",
        cnpj:         "61702829000120",
        cep:          "22031030",
        endereco:     "Rua Silva Castro",
        numero:       "48",
        bairro:       "Copacabana",
        complemento:  "8 andar",
        cidade:       "Rio de Janeiro",
        estado:       "RJ",
        ddd:          "22",
        telefone:     "988225511",
        email:        "pjbank-ruby-sdk@mailinator.com"
      }
    end

    context "when success" do
      it "returns the object with correct data" do
        VCR.use_cassette("contadigital/credenciamento/credenciamento/sucesso") do
          response = subject.credenciamento(dados)
          expect(response.credencial).to_not be_nil
          expect(response.chave).to_not be_nil
        end
      end
    end

    context "when failure" do
      before { dados[:cnpj] = "" }

      context "when validation error (400)" do
        it "raises PJBank::RequestError" do
          VCR.use_cassette("contadigital/credenciamento/credenciamento/erro_400") do
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
end
