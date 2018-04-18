require_relative 'base'

module PJBank
  module Contadigital
    module Credenciamento
      class Credenciamento < Base
        def credenciamento(dados)
          http.post("#{base_url_path}/", payload: dados)
        end
      end
    end
  end
end
