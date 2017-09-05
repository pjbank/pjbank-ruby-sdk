class RecebimentoTesteController < ApplicationController
    require 'json'
    def index
        
    end

    def credenciamento
        @json = false
        @res = PJBank::Recebimento.boleto(
                    acao: :credenciamento, 
                    dados: {
                        nome_empresa: "#{params[:nome_empresa]}",
                        conta_repasse: "#{params[:conta_repasse]}",
                        agencia_repasse: "#{params[:agencia_repasse]}",
                        banco_repasse: "#{params[:banco_repasse]}",
                        cnpj: "#{params[:cnpj]}",  
                        ddd: "#{params[:ddd]}",  
                        telefone: "#{params[:telefone]}",  
                        email: "#{params[:email]}"
                    }
                )
        if(@res != "400 Bad Request")
            @res = ActiveSupport::JSON.decode(@res)
            @json = true        
        end
    end

    def emitir
        @json = false
        @res = PJBank::Recebimento.boleto(
                    acao: :emitir,
                    aut: {
                        credencial: "#{params[:credencial]}",
                    }, 
                    dados: {
                        vencimento: "#{params[:vencimento]}",
                        valor: "#{params[:valor]}",
                        juros: "#{params[:juros]}",
                        multa: "#{params[:multa]}",
                        desconto: "#{params[:desconto]}",  
                        nome_cliente: "#{params[:nome_cliente]}",  
                        cpf_cliente: "#{params[:cpf_cliente]}",  
                        endereco_cliente: "#{params[:endereco_cliente]}",
                        numero_cliente: "#{params[:numero_cliente]}",
                        complemento_cliente: "#{params[:complemento_cliente]}",
                        bairro_cliente: "#{params[:bairro_cliente]}",
                        cidade_cliente: "#{params[:cidade_cliente]}",
                        estado_cliente: "#{params[:estado_cliente]}",
                        cep_cliente: "#{params[:cep_cliente]}",
                        logo_url: "#{params[:logo_url]}",
                        texto: "#{params[:texto]}",
                        grupo: "#{params[:grupo]}",
                        pedido_numero: "#{params[:pedido_numero]}",
                    }
                )

        if(@res != "400 Bad Request")
            @res = ActiveSupport::JSON.decode(@res)
            @json = true        
        end
    end

    def emissao
        @json = false
        @res = PJBank::Recebimento.boleto(
                    acao: :impressaoLote,
                    aut: {
                        credencial: "#{params[:credencial]}",
                        chave: "#{params[:chave]}"
                    }, 
                    dados: {
                        pedido_numero: "#{params[:pedido_numero]}",
                        formato: "#{params[:formato]}",
                    }
                )
        if(@res != "400 Bad Request")
            @res = ActiveSupport::JSON.decode(@res)
            @json = true        
        end
    end

    def carne
        @json = false
        @res = PJBank::Recebimento.boleto(
                    acao: :impressaoCarne, 
                    aut: {
                        credencial: "#{params[:credencial]}",
                        chave: "#{params[:chave]}"
                    }, 
                    dados: {
                        pedido_numero: "#{params[:pedido_numero]}",
                        formato: "#{params[:formato]}",
                    }
                )
        if(@res != "400 Bad Request")
            @res = ActiveSupport::JSON.decode(@res)
            @json = true        
        end
    end
end
