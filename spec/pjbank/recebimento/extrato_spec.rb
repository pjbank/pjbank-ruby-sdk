require 'spec_helper'

RSpec.describe PJBank::Recebimento::Extrato do
  let(:credencial) { "15524442a57788c4f3109c939056d821302155a9" }
  let(:chave)      { "027e30fbc768931e0682479e0f0404a0fcc8886b" }

  let(:http) { PJBank::Http.new(credencial: credencial, chave: chave) }

  subject { described_class.new(http) }

  describe "#transacoes" do
    context "when TODO: fazer um teste para cada grupo de filtros (sem filtro, efetivado, por data, paginado) e outro passando vários juntos" do
      it "TODO" do
        VCR.use_cassette("recebimento/extrato/transacoes/x") do
          pending("TODO")
          fail
        end
      end
    end
  end
end
