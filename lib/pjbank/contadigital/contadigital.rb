require_relative 'credenciamento/credenciamento'
require_relative 'recebimento/boleto'
require_relative 'transacoes/transacoes'

class ContaDigitalController

    def initialize

        # @credenciamentoController = CredenciamentoContaDigital.new

        # @transacoesController = TransacoesContaDigital.new

    end

    def credenciamento

        puts "Digite a opção:\n1 - Credenciamento\n2 - Consulta\n3 - Boleto para adicionar saldo"
        opcao = gets.chomp

        case opcao
            when '1'
                @credenciamentoController.credenciamento
            when '2'
                @credenciamentoController.consulta
            when '3'
                @credenciamentoController.boleto
        end

    end

    def transacoes
        puts "Digite a opção:\n1 - Pagamento de boleto"
        opcao = gets.chomp

        case opcao
            when '1'
                @transacoesController.pagamentoBoleto
        end
    end

    # def subcontas

    # end

    # def administradores

    # end

    # def documentos

    # end

end
