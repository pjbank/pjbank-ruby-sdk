class CartaoRecebimento

    def credenciamento dados
         begin
            response = RestClient::Request.execute(
                method: :post,
                url: 'https://api.pjbank.com.br/recebimentos/',
                headers: {
                    "Content-Type": "Application/json"
                },
                payload: {
                    nome_empresa: "#{dados[:nome_empresa]}",
                    conta_repasse: "#{dados[:conta_repasse]}",
                    agencia_repasse: "#{dados[:agencia_repasse]}",
                    banco_repasse: "#{dados[:banco_repasse]}",
                    cnpj: "#{dados[:cnpj]}",  
                    ddd: "#{dados[:ddd]}",  
                    telefone: "#{dados[:telefone]}",  
                    email: "#{dados[:email]}",
                    cartao: "#{dados[:cartao]}"
                }
            )

            return response
        rescue RestClient::ExceptionWithResponse => err
            return err
        end
    end

    def tokenizar dados, aut
        begin
            response = RestClient::Request.execute(
                method: :post,
                url: "https://api.pjbank.com.br/recebimentos/#{aut[:credencial_cartao]}/tokens",
                headers: { 
                    "x-chave": "#{aut[:chave_cartao]}",
                    "Content-Type": "Application/json"
                },
                payload: {
                    nome_cartao: "#{dados[:nome_cartao]}",
                    numero_cartao: "#{dados[:numero_cartao]}",
                    mes_vencimento: "#{dados[:mes_vencimento]}",
                    ano_vencimento: "#{dados[:ano_vencimento]}",
                    cpf_cartao: "#{dados[:cpf_cartao]}",
                    email_cartao: "#{dados[:email_cartao]}",
                    celular_cartao: "#{dados[:celular_cartao]}",
                    codigo_cvv: "#{dados[:codigo_ccv]}",
                }
            )

            return response
        rescue RestClient::ExceptionWithResponse => err
            return err
        end
    end

    def emitirToken dados, aut
        begin
            response = RestClient::Request.execute(
                method: :post,
                url: "https://api.pjbank.com.br/recebimentos/#{aut[:credencial_cartao]}/transacoes",
                headers: { 
                    "x-chave": "#{aut[:chave_cartao]}",
                    "Content-Type": "Application/json"
                },
                payload: {
                    token_cartao: "#{dados[:token_cartao]}",
                    valor: "#{dados[:valor]}",
                    parcelas: "#{dados[:parcelas]}",
                    descricao_pagamento: "#{dados[:descricao_pagamento]}",
                }
            )

            return response
        rescue RestClient::ExceptionWithResponse => err
            return err
        end
    end

    def emitirCartao dados, aut
        begin
            response = RestClient::Request.execute(
                method: :post,
                url: "https://api.pjbank.com.br/recebimentos/#{aut[:credencial_cartao]}/transacoes",
                headers: { 
                    "x-chave": "#{aut[:chave_cartao]}",
                    "Content-Type": "Application/json"
                },
                payload: {
                    numero_cartao: "#{dados[:numero_cartao]}",
                    nome_cartao: "#{dados[:nome_cartao]}",
                    mes_vencimento: "#{dados[:mes_vencimento]}",
                    ano_vencimento: "#{dados[:ano_vencimento]}",
                    cpf_cartao: "#{dados[:cpf_cartao]}",
                    email_cartao: "#{dados[:email_cartao]}",
                    celular_cartao: "#{dados[:celular_cartao]}",
                    codigo_ccv: "#{dados[:codigo_ccv]}",
                    valor: "#{dados[:valor]}",
                    parcelas: "#{dados[:parcelas]}",
                    descricao_pagamento: "#{dados[:descricao_pagamento]}",
                }
            )

            return response
        rescue RestClient::ExceptionWithResponse => err
            return err
        end
    end

    def cancelarTransacao aut
        begin
            response = RestClient::Request.execute(
                method: :delete,
                url: "https://api.pjbank.com.br/recebimentos/#{aut[:credencial_cartao]}/transacoes/#{aut[:tid_cartao]}",
                headers: { 
                    "x-chave": "#{aut[:chave_cartao]}",
                    "Content-Type": "Application/json"
                }
            )

            return response
        rescue RestClient::ExceptionWithResponse => err
            return err
        end
    end

end