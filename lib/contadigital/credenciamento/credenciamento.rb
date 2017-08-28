class CredenciamentoContaDigital

    def credenciamento
        
        puts "Nome da empresa. Ex: Exemplo Conta Digital"
        nome_empresa = gets.chomp
        puts "CNPJ. Ex: 60285827000110"
        cnpj = gets.chomp
        puts "CEP. Ex: 13032-525"
        cep = gets.chomp
        puts "Endereço. Ex: Rua Joaquim Vilac"
        endereco = gets.chomp
        puts "Número. Ex: 509"
        numero = gets.chomp
        puts "Bairro. Ex: Vila Teixeira"
        bairro = gets.chomp
        puts "Complemento. Ex: (opcional)"
        complemento = gets.chomp
        puts "Cidade. Ex: Campinas"
        cidade = gets.chomp
        puts "Estado. Ex: SP"
        estado = gets.chomp
        puts "DDD. Ex: 19"
        ddd = gets.chomp
        puts "Telefone. Ex: 987652345"
        telefone = gets.chomp
        puts "E-mail. Ex: api@pjbank.com.br"
        email = gets.chomp
        
        puts "\nLoading...\n"

        begin
            response = RestClient::Request.execute(
                method: :post,
                url: 'https://api.pjbank.com.br/contadigital/',
                header: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                payload: {
                    nome_empresa: "#{nome_empresa}",  
                    cnpj: "#{cnpj}",  
                    cep: "#{cep}",  
                    endereco: "#{endereco}",  
                    numero: numero,  
                    bairro: "#{bairro}",  
                    complemento: "#{complemento}",  
                    cidade: "#{cidade}",  
                    estado: "#{estado}",  
                    ddd: "#{ddd}",  
                    telefone: "#{telefone}",  
                    email: "#{email}"
                }
            )

            puts response
        rescue RestClient::ExceptionWithResponse => err
            puts err
        end
    end

    def consulta

        puts "Digite a Credencial. Ex: eb2af021c5e2448c343965a7a80d7d090eb64164"
        credencial = gets.chomp
        puts "Digite a Chave. Ex: a834d47e283dd12f50a1b3a771603ae9dfd5a32c"
        chave = gets.chomp

        puts "\nLoading...\n"

        begin
            response = RestClient::Request.execute(
                method: :get,
                url: "https://api.pjbank.com.br/contadigital/#{credencial}",
                headers: {
                    'x-chave-conta': chave,
                }
            )

            puts response
        rescue RestClient::ExceptionWithResponse => err
            puts err
        end

    end

    def boleto
        
        puts "Digite a Credencial. Ex: eb2af021c5e2448c343965a7a80d7d090eb64164"
        credencial = gets.chomp
        puts "Digite a Chave. Ex: a834d47e283dd12f50a1b3a771603ae9dfd5a32c"
        chave = gets.chomp
        puts "Valor a ser adicionado. Ex: 900.00"
        valor = gets.chomp

        puts "\nLoading...\n"

        begin
            response = RestClient::Request.execute(
                method: :post,
                url: "https://api.pjbank.com.br/contadigital/#{credencial}",
                headers: {
                    'x-chave-conta': chave,
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                payload: {
                    'valor': valor
                }
            )

            puts response
        rescue RestClient::ExceptionWithResponse => err
            puts err
        end

    end

end