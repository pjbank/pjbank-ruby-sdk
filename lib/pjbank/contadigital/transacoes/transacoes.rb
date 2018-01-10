class TransacoesContaDigital

    def pagamentoBoleto
        
        puts "Digite a Credencial. Ex: eb2af021c5e2448c343965a7a80d7d090eb64164"
        credencial = gets.chomp
        # puts "Digite a Chave. Ex: a834d47e283dd12f50a1b3a771603ae9dfd5a32c"
        # chave = gets.chomp
        # puts "Valor a ser adicionado. Ex: 900.00"
        # valor = gets.chomp

        puts "\nLoading...\n"

        begin
            response = RestClient::Request.execute(
                method: :post,
                url: "https://api.pjbank.com.br/contadigital/#{credencial}/transacoes",
                headers: {
                    'x-chave-conta': chave,
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                payload: {
                    'lote': [{
                        'data_vencimento': '08/30/2017',
                        'data_pagamento': '08/30/2017',
                        'valor': 1.00,
                        'codigo_barras': '03399699255873781001843279301014571980000001000'
                    }]
                }
            )

            return response
        rescue RestClient::ExceptionWithResponse => err
            return err
        end

    end

end