require 'rest-client'
require 'json'
require_relative 'contadigital/contadigital'
require_relative 'recebimento/recebimento'

module PJBank


    class Recebimento
        
        @@contaController = ContaDigitalController.new
        @@recebimentoController = RecebimentoController.new

        def self.recebimento opcao
            puts opcao.acao
            # @@recebimentoController.credenciamento
            
        end
    end
end