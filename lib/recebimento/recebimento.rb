require_relative 'boleto/boleto'

class RecebimentoController

    def initialize

        @boletoController = BoletoRecebimento.new
        
    end

    def credenciamento

        puts "Digite sua ação:\n1 - Credenciamento\n2 - Transações\n3 - Impressão de boletos em lote\n4 - Impressão de carne"
        opcao = gets.chomp

        case opcao
            when '1' 
                @boletoController.credenciamento
            when '2'
                @boletoController.emitir
            when '3'
                @boletoController.impressaoLote
            when '4'
                @boletoController.impressaoCarne
        end

    end

    # def transacoes
    #     puts "Digite a opção:\n1 - Pagamento de boleto"
    #     opcao = gets.chomp

    #     case opcao
    #         when '1' 
    #             @transacoesController.pagamentoBoleto
    #     end
    # end

    # def subcontas

    # end

    # def administradores

    # end

    # def documentos

    # end

end