require_relative 'base'

module PJBank
  module Recebimento
    # TODO: tem que fazer testes (ou contactar o suporte) para confirmar como se comporta esse extrato, visto que só tem
    # exemplos usando a credencial de cartão. Se for individual para cada credencial, faz mais sentido que esse método
    # esteja em cada uma das classes, por exemplo, PJBank::Boleto.extrato e PJBank::Cartao.extrato
    class Extrato < Base
      def transacoes(params={})
        http.get("#{base_url_path}/transacoes", params)
      end
    end
  end
end
