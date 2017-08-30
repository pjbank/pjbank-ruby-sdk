require 'rest-client'
require 'json'
require_relative 'contadigital/contadigital'
require_relative 'recebimento/recebimento'

module PJBank

    class Recebimento
        
        @@recebimentoController = RecebimentoController.new

        def self.boleto(params)
            @@recebimentoController.public_send(params[:acao], params) 
        end

    end

    class ContaDigital

        @@contaController = ContaDigitalController.new
        
    end
end