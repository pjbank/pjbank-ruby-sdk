module PJBank
  module Recebimento
    class Base
      attr_reader :http

      def initialize(http)
        @http = http
      end

      private

      def base_url_path
        "/recebimentos"
      end
    end
  end
end
