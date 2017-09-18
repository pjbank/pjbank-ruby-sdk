require_relative 'boleto/boleto'
require_relative 'cartao/cartao'
require_relative 'extrato/extrato'

module RecebimentoController

    class Boleto
        def initialize
            @boletoController = BoletoRecebimento.new
        end

        def credenciamento params
            dados = params[:dados]
            @boletoController.credenciamento dados
        end

        def emitir params
            dados = params[:dados]
            aut = params[:aut]
            @boletoController.emitir dados, aut
        end

        def impressaoLote params
            dados = params[:dados]
            aut = params[:aut]
            @boletoController.impressaoLote dados, aut
        end

        def impressaoCarne params
            dados = params[:dados]
            aut = params[:aut]
            @boletoController.impressaoCarne dados, aut
        end
    end

    class Cartao
        def initialize
            @cartaoController = CartaoRecebimento.new
        end

        def credenciamento params
            dados = params[:dados]
            @cartaoController.credenciamento dados
        end

        def tokenizar params
            dados = params[:dados]
            aut = params[:aut]
            @cartaoController.tokenizar dados, aut
        end

        def emitirToken params
            dados = params[:dados]
            aut = params[:aut]
            @cartaoController.emitirToken dados, aut
        end

        def emitirCartao params
            dados = params[:dados]
            aut = params[:aut]
            @cartaoController.emitirCartao dados, aut
        end

        def cancelarTransacao params
            aut = params[:aut]
            @cartaoController.cancelarTransacao aut
        end
    end

    class Extrato
        def initialize
            @extratoController = ExtratoRecebimento.new
        end

        def pagamentos params
            aut = params[:aut]
            @extratoController.pagamentos aut
        end

        def pagamentosLiquidados params
            aut = params[:aut]
            @extratoController.pagamentosLiquidados aut
        end

        def pagamentosFiltrados params
            aut = params[:aut]
            @extratoController.pagamentosFiltrados aut
        end

        def pagamentosPaginados params
            aut = params[:aut]
            @extratoController.pagamentosPaginados aut
        end
    end

end