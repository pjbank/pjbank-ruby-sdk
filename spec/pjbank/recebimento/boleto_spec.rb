require 'spec_helper'

RSpec.describe PJBank::Recebimento::Boleto do
  let(:credencial) { "15524442a57788c4f3109c939056d821302155a9" }
  let(:chave)      { "027e30fbc768931e0682479e0f0404a0fcc8886b" }

  let(:http) { PJBank::Http.new(credencial: credencial, chave: chave) }

  subject { described_class.new(http) }

  describe "#credenciamento" do
    let(:http) { PJBank::Http.new }

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

    context "when success" do
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
      before { dados[:cnpj] = "" }

      context "when validation error (400)" do
        it "raises PJBank::RequestError" do
          VCR.use_cassette("recebimento/boleto/credenciamento/erro_400") do
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

  describe "#emitir" do
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
        texto:               "",
        grupo:               "Boletos001",
      }
    end

    context "when success" do
      it "returns the object with correct data" do
        VCR.use_cassette("recebimento/boleto/emitir/sucesso") do
          response = subject.emitir(dados)
          expect(response.status).to eql("201")
          expect(response.linhaDigitavel).to_not be_nil
          expect(response.linkBoleto).to_not be_nil
        end
      end
    end

    context "when failure" do
      context "when validation error (500)" do
        let(:dados) do
          { valor: "100.55" }
        end

        it "raises PJBank::RequestError" do
          VCR.use_cassette("recebimento/boleto/emitir/erro_400") do
            expect { subject.emitir(dados) }.to raise_error do |error|
              expect(error).to be_a(PJBank::RequestError)
              expect(error.message).to eql("Vencimento, este campo não pode ser vazio.")
              expect(error.code).to eql(500)
            end
          end
        end
      end

      context "when unauthorized error (401)" do
        it "raises PJBank::RequestError" do
          VCR.use_cassette("recebimento/boleto/emitir/erro_401") do
            expect { subject.emitir(dados) }.to raise_error do |error|
              expect(error).to be_a(PJBank::RequestError)
              expect(error.message).to eql("Credencial inválida.")
              expect(error.code).to eql(401)
            end
          end
        end
      end

      context "when unauthorized error (504)" do
        it "raises PJBank::RequestTimeout" do
          VCR.use_cassette("recebimento/boleto/emitir/erro_504") do
            expect { subject.emitir(dados) }.to raise_error(PJBank::RequestTimeout)
          end
        end
      end

      context "when locked error (423)" do
        # É necessário que tenha emitido a pouco tempo um boleto com esse mesmo pedido_numero para simular esse erro.
        before { dados[:pedido_numero] = "8972" }

        it "raises PJBank::RequestError" do
          VCR.use_cassette("recebimento/boleto/emitir/erro_423") do
            pending("Na verdade está sendo retornado o status http 200, mas deveria ser 423. Aguardando posição do suporte")
            expect { subject.emitir(dados) }.to raise_error(PJBank::RequestError)
            fail
          end
        end
      end
    end
  end

  describe "#impressao" do
    let(:dados) do
      {
        pedidos_numero: ["33215"]
      }
    end

    # TODO: aguardar o servidor de sandbox parar de dar timeout para rodar o teste.
    xit "returns the object with correct data" do
      VCR.use_cassette("recebimento/boleto/impressao/sucesso") do
        response = subject.impressao(dados)
        expect(response.status).to eql("200")
        expect(response.linkBoleto).to_not be_nil
      end
    end
  end
end
