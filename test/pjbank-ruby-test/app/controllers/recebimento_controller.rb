
class RecebimentoController < ApplicationController
    
    # Para acessar as variáveis nas views, é necessário usar elas como váriaveis de instância, colocando o @ no começo dela
    def index
        PJBank::Recebimento.boleto(
            acao: :credenciamento, 
            dados: {
                nome_empresa: "Exemplo Conta Digital",
                conta_repasse: "99999-9",
                agencia_repasse: "00001",
                banco_repasse: "001",
                cnpj: "06949753000124",  
                ddd: "19",  
                telefone: "987652345",  
                email: "api@pjbank.com.br"
            }
        )
    end

    def search
        @teste = "teste"
    end
end
