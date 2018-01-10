require_relative 'boleto'
require_relative 'cartao'
require_relative 'extrato'

module PJBank
  module Recebimento
    class Controller
      attr_reader :http

      def initialize(http)
        @http = http
      end

      def boleto
        Recebimento::Boleto.new(http)
      end

      def cartao
        Recebimento::Cartao.new(http)
      end

      def extrato
        Recebimento::Extrato.new(http)
      end
    end
  end
end
