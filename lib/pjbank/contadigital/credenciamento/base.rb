module PJBank
  module Contadigital
    module Credenciamento
      class Base
        attr_reader :http

        def initialize(http)
          @http = http
        end

        private

        def base_url_path
          "/contadigital"
        end
      end
    end
  end
end
