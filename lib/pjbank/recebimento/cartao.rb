require_relative 'base'

module PJBank
  module Recebimento
    class Cartao < Base
      def credenciamento(dados)
        http.post("#{base_url_path}/", { payload: dados.merge(cartao: true) })
      end

      def tokenizar(dados)
        http.post("#{base_url_path}/:credencial/tokens", { payload: dados })
      end

      def cancelar(tid)
        http.delete("#{base_url_path}/:credencial/transacoes/#{tid}")
      end
    end
  end
end
