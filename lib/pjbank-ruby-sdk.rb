require 'rest-client'

require File.dirname(__FILE__) + '/pjbank_ruby_sdk/version'
require File.dirname(__FILE__) + '/pjbank_ruby_sdk/contadigital/contadigital'
require File.dirname(__FILE__) + '/pjbank_ruby_sdk/recebimento/recebimento'

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
