class ExtratoRecebimento
    def pagamentos aut
        begin
            response = RestClient::Request.execute(
                method: :get,
                url: "https://api.pjbank.com.br/recebimentos/#{aut[:credencial_cartao]}/transacoes",
                headers: {
                    "x-chave": "#{aut[:chave_cartao]}",
                    "Content-Type": "Application/json"
                }
            )

            return response
        rescue RestClient::ExceptionWithResponse => err
            return err.response
        end
    end

    def pagamentosLiquidados aut
        begin
            response = RestClient::Request.execute(
                method: :get,
                url: "https://api.pjbank.com.br/recebimentos/#{aut[:credencial_cartao]}/transacoes?pago=1",
                headers: {
                    "x-chave": "#{aut[:chave_cartao]}",
                    "Content-Type": "Application/json"
                }
            )

            return response
        rescue RestClient::ExceptionWithResponse => err
            return err.response
        end
    end

    def pagamentosFiltrados aut
        begin
            response = RestClient::Request.execute(
                method: :get,
                url: "https://api.pjbank.com.br/recebimentos/#{aut[:credencial_cartao]}/transacoes?data_inicio=#{aut[:data_inicio]}&data_fim=#{aut[:data_fim]}",
                headers: {
                    "x-chave": "#{aut[:chave_cartao]}",
                    "Content-Type": "Application/json"
                }
            )

            return response
        rescue RestClient::ExceptionWithResponse => err
            return err.response
        end
    end

    def pagamentosPaginados aut
        begin
            response = RestClient::Request.execute(
                method: :get,
                url: "https://api.pjbank.com.br/recebimentos/#{aut[:credencial_cartao]}/transacoes?pagina=#{aut[:pagina]}",
                headers: {
                    "x-chave": "#{aut[:chave_cartao]}",
                    "Content-Type": "Application/json"
                }
            )

            return response
        rescue RestClient::ExceptionWithResponse => err
            return err.response
        end
    end
end