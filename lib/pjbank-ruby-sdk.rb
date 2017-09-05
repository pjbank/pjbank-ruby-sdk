require 'rest-client'

require File.dirname(__FILE__) + '/pjbank_ruby_sdk'
require File.dirname(__FILE__) + '/pjbank_ruby_sdk/version'
require File.dirname(__FILE__) + '/pjbank_ruby_sdk/contadigital/contadigital'
require File.dirname(__FILE__) + '/pjbank_ruby_sdk/recebimento/recebimento'

module PJBank
    class Recebimento
        
        def self.boleto(params)
            @@recebimentoController = RecebimentoController::Boleto.new
            @@recebimentoController.public_send(params[:acao], params) 
        end

        def self.cartao(params)
            @@recebimentoController = RecebimentoController::Cartao.new
            @@recebimentoController.public_send(params[:acao], params) 
        end

        def self.extrato(params)
            recebimentoController = RecebimentoController::Extrato.new
            recebimentoController.public_send(params[:acao], params)
        end
    end

    class ContaDigital

        @@contaController = ContaDigitalController.new
        
    end
end
