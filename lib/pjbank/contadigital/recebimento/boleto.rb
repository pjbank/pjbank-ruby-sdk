require_relative 'base'

module PJBank
  module Contadigital
    module Recebimento
      class Boleto < Base
        def emitir(dados)
          http.post("#{base_url_path}/:credencial/recebimentos/transacoes", payload: dados)
        end

        def cancelar(id)
          http.delete("#{base_url_path}/:credencial/recebimentos/transacoes/#{id}")
        end
      end
    end
  end
end
