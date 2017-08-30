require_relative 'boleto/boleto'

class RecebimentoController

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