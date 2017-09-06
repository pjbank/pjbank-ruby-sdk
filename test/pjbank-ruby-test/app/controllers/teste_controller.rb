class TesteController < ApplicationController
    def index
        @tes = "dane-se"
        @teste = PJBank::Recebimento.boleto(
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
