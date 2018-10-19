require_relative 'base'

module PJBank
  module Recebimento
    class Boleto < Base
      def credenciamento(dados)
        http.post("#{base_url_path}/", payload: dados)
      end

      def impressao(dados)
        http.post("#{base_url_path}/:credencial/transacoes/lotes", payload: dados)
      end
    end
  end
end
