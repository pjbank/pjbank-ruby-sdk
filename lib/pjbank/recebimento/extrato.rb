require_relative 'base'

module PJBank
  module Recebimento
    class Extrato < Base
      # TODO: Melhorar essa interface. Está bem ruim, pois não temos como mesclar os parâmetros, por exemplo, quero os
      # pagamentos efetivados, de 01/10/2017 até 31/12/2017, na página 2. Também não tem como pegar os pagamentos não
      # efetuados (pago=0), o ideal seria ter um método só que recebe os parâmetros.

      def pagamentos
        http.get("#{base_url_path}/transacoes")
      end

      def pagamentos_liquidados
        http.get("#{base_url_path}/transacoes?pago=1")
      end

      def pagamentos_filtrados(dados)
        http.get("#{base_url_path}/transacoes?data_inicio=#{dados[:data_inicio]}&data_fim=#{dados[:data_fim]}")
      end

      def pagamentos_paginados(dados)
        http.get("#{base_url_path}/transacoes?pagina=#{aut[:pagina]}")
      end
    end
  end
end
