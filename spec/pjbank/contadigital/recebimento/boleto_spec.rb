require 'spec_helper'

RSpec.describe PJBank::Contadigital::Recebimento::Boleto do
  let(:credencial) { "a92c4a6fae4a8f9e06f141ca4561679f8a9d49a2" }
  let(:chave)      { "6c1c05b0ccff1e4d3c8c7c28078d4928ec5d99db" }

  let(:http) { PJBank::Http.new(credencial: credencial, chave: chave) }

  subject { described_class.new(http) }

  describe "#emitir" do
    let(:dados) do
      {
        vencimento: "12/30/2019",
        valor: 50.75,
        juros: 0,
        multa: 0,
        desconto: "",
        nome_cliente: "Cliente de Exemplo",
        cpf_cliente: "62936576000112",
        endereco_cliente: "Rua Joaquim Vilac",
        numero_cliente: "509",
        complemento_cliente: "",
        bairro_cliente: "Vila Teixeira",
        cidade_cliente: "Campinas",
        estado_cliente: "SP",
        cep_cliente: "13301510",
        logo_url: "http://wallpapercave.com/wp/xK64fR4.jpg",
        texto: "Exemplo de emissão de boleto",
        grupo: "Boletos",
        pedido_numero: "2342"
      }
    end

    context "when success" do
      context "when does not exist with same pedido_numero" do
        it "returns the object with correct data" do
          VCR.use_cassette("contadigital/recebimento/boleto/emitir/sucesso") do
            response = subject.emitir(dados)
            expect(response.status).to eql("201")
            expect(response.linhaDigitavel).to_not be_nil
            expect(response.linkBoleto).to_not be_nil
          end
        end
      end

      context "when exists with same pedido_numero" do
        # É necessário que tenha emitido um boleto com esse mesmo pedido_numero para simular essa resposta
        before { dados[:pedido_numero] = "2342" }

        it "returns the object with correct data" do
          VCR.use_cassette("contadigital/recebimento/boleto/emitir/sucesso_existent") do
            response = subject.emitir(dados)
            expect(response.status).to eql("200")
            expect(response.pedido_numero).to be_nil
            expect(response.linhaDigitavel).to_not be_nil
            expect(response.linkBoleto).to_not be_nil
          end
        end
      end
    end

    context "when failure" do
      context "when exists a canceled with same pedido_numero (500)" do
        # É necessário que tenha emitido um boleto com esse mesmo pedido_numero e depois cancelado ele
        before { dados[:pedido_numero] = "552224411" }

        xit "raises PJBank::RequestError" do
          VCR.use_cassette("contadigital/recebimento/boleto/emitir/erro_reemitir_cancelada") do
            pending("TODO: ver com o suporte porque está retornando um array sendo que não é uma emissão em lote")
            expect { subject.emitir(dados) }.to raise_error do |error|
              expect(error).to be_a(PJBank::RequestError)
              expect(error.message).to eql("Cobrança que corresponde a esse pedido 1 foi invalidada.")
              expect(error.code).to eql(500)
            end
          end
        end
      end

      context "when validation error (500)" do
        let(:dados) do
          { valor: "100.55" }
        end

        it "raises PJBank::RequestError" do
          VCR.use_cassette("contadigital/recebimento/boleto/emitir/erro_500") do
            expect { subject.emitir(dados) }.to raise_error do |error|
              expect(error).to be_a(PJBank::RequestError)
              expect(error.message).to eql("Vencimento, este campo não pode ser vazio.")
              expect(error.code).to eql(500)
            end
          end
        end
      end

      context "when Badrequest error (400)" do
        let(:credencial) { "109c93905615524442a57788c4f3d821302155a9" }

        it "raises PJBank::RequestError" do
          VCR.use_cassette("contadigital/recebimento/boleto/emitir/erro_400") do
            expect { subject.emitir(dados) }.to raise_error do |error|
              expect(error).to be_a(PJBank::RequestError)
              expect(error.message).to eql("Credencial não localizada.")
              expect(error.code).to eql(400)
            end
          end
        end
      end
    end
  end

  describe "#cancelar" do
    let(:pedido_numero) { "69087" }
    let(:id_unico)      { "123336" }

    xit "returns the object with correct data" do
      VCR.use_cassette("contadigital/recebimento/boleto/cancelar/sucesso") do
        response = subject.cancelar(pedido_numero)
        expect(response.status).to eql("200")
        expect(response.msg).to eql("Cobrança #{id_unico} invalidada com sucesso.")
      end
    end
  end
end
