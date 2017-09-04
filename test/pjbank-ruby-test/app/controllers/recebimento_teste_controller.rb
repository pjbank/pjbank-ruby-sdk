class RecebimentoTesteController < ApplicationController
    def index
        
    end

    def credenciamento
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
    end

    def emitir
        @res = PJBank::Recebimento.boleto(
                    acao: :credenciamento, 
                    dados: {
                        nome_empresa: "Exemplo Conta Digital",
                        conta_repasse: "99999-9",
                        agencia_repasse: "00001",
                        banco_repasse: "001",
                        cnpj: "36361126000139",  
                        ddd: "19",  
                        telefone: "987652345",  
                        email: "api@pjbank.com.br"
                    }
                )
    end

    def emissao
        @res = PJBank::Recebimento.boleto(
                    acao: :credenciamento, 
                    dados: {
                        nome_empresa: "Exemplo Conta Digital",
                        conta_repasse: "99999-9",
                        agencia_repasse: "00001",
                        banco_repasse: "001",
                        cnpj: "36361126000139",  
                        ddd: "19",  
                        telefone: "987652345",  
                        email: "api@pjbank.com.br"
                    }
                )
    end

    def carne
        @res = PJBank::Recebimento.boleto(
                    acao: :credenciamento, 
                    dados: {
                        nome_empresa: "Exemplo Conta Digital",
                        conta_repasse: "99999-9",
                        agencia_repasse: "00001",
                        banco_repasse: "001",
                        cnpj: "36361126000139",  
                        ddd: "19",  
                        telefone: "987652345",  
                        email: "api@pjbank.com.br"
                    }
                )
    end
end
