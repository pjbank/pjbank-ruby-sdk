class BoletoRecebimento

    # TESTE - OK        
    def credenciamento
        
        puts "Nome da empresa. Ex: Exemplo Conta Digital"
        nome_empresa = gets.chomp
        puts "Número da conta bancaria que será feito o repasse. Ex: 99999-9"
        conta_repasse = gets.chomp
        puts "Agência da conta bancaria que será feito o repasse. Ex: 00001 / 0000-1"
        agencia_repasse = gets.chomp
        puts "Número do banco que será feito o repasse. Ex: 001"
        banco_repasse = gets.chomp
        puts "CNPJ. Ex: 60285827000110"
        cnpj = gets.chomp
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
                url: 'https://api.pjbank.com.br/recebimentos/',
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                payload: {
                    nome_empresa: "#{nome_empresa}",
                    conta_repasse: "#{conta_repasse}",
                    agencia_repasse: "#{agencia_repasse}",
                    banco_repasse: "#{banco_repasse}",
                    cnpj: "#{cnpj}",  
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

    # TESTE - OK
    def emitir

        puts "Digite a Credencial. Ex: d3418668b85cea70aa28965eafaf927cd34d004c"
        credencial = gets.chomp
        
        puts "\n"

        puts "Vencimento da cobraça. Ex: 12/30/2019"
        vencimento = gets.chomp
        puts "Valor a ser pago. Ex: 1000.98"
        valor = gets.chomp
        puts "Juros ao dia. Ex: 0"
        juros = gets.chomp
        puts "Multa por atraso. Ex: 0.98"
        multa = gets.chomp
        puts "Desconto por pontualidade. Ex: 9.58"
        desconto = gets.chomp
        puts "Nome do cliente. Ex: Cliente de exemplo"
        nome_cliente = gets.chomp
        puts "CPF do cliente. Ex: 62936576000112"
        cpf_cliente = gets.chomp
        puts "Endereço do cliente. Ex: Rua Joaquim Vilac"
        endereco_cliente = gets.chomp
        puts "Número do endereço do cliente. Ex: 509"
        numero_cliente = gets.chomp
        puts "Complemento do endereço do cliente. (opcional)"
        complemento_cliente = gets.chomp
        puts "Bairro do endereço do cliente. Ex: Vila Teixeira"
        bairro_cliente = gets.chomp
        puts "Cidade do cliente. Ex: Campinas"
        cidade_cliente = gets.chomp
        puts "Estado do cliente. Ex: SP"
        estado_cliente = gets.chomp
        puts "CEP do cliente. Ex: 13301510"
        cep_cliente = gets.chomp
        puts "Logo da empresa. Ex: http://wallpapercave.com/wp/xK64fR4.jpg"
        logo_url = gets.chomp
        puts "Texto que ficará no topo do boleto. (opcional)"
        texto = gets.chomp
        puts "Identificação do grupo. Ex: Boletos001"
        grupo = gets.chomp
        puts "Número do pedido da cobrança. Ex: 8972"
        pedido_numero = gets.chomp

        puts "\nLoading...\n"

        begin
            response = RestClient::Request.execute(
                method: :post,
                url: "https://api.pjbank.com.br/recebimentos/#{credencial}/transacoes",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                payload: {
                    vencimento: "#{vencimento}",
                    valor: "#{valor}",
                    juros: "#{juros}",
                    multa: "#{multa}",
                    desconto: "#{desconto}",
                    nome_cliente: "#{nome_cliente}",  
                    cpf_cliente: "#{cpf_cliente}",  
                    endereco_cliente: "#{endereco_cliente}",  
                    numero_cliente: numero_cliente,  
                    complemento_cliente: "#{complemento_cliente}",  
                    bairro_cliente: "#{bairro_cliente}",  
                    cidade_cliente: "#{cidade_cliente}",  
                    estado_cliente: "#{estado_cliente}",  
                    cep_cliente: "#{cep_cliente}",  
                    logo_url: "#{logo_url}",  
                    grupo: "#{grupo}",
                    pedido_numero: "#{pedido_numero}"
                }
            )

            puts response
        rescue RestClient::ExceptionWithResponse => err
            puts err
        end

    end

    # TESTE - OK
    def impressaoLote

        puts "Digite a Credencial. Ex: d3418668b85cea70aa28965eafaf927cd34d004c"
        credencial = gets.chomp
        puts "Digite a Chave. Ex: 46e79d6d5161336afa7b98f01236efacf5d0f24b"
        chave = gets.chomp
        
        puts "\n"

        puts "Array com número do pedido da cobrança. Ex: 8972"
        pedido_numero = gets.chomp

        puts "\nLoading...\n"

        begin
            response = RestClient::Request.execute(
                method: :post,
                url: "https://api.pjbank.com.br/recebimentos/#{credencial}/transacoes/lotes",
                headers: {
                    "x-chave": chave,
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                payload: {
                    pedido_numero: pedido_numero,
                    # formato: "#{formato}"
                }
            )

            puts response
        rescue RestClient::ExceptionWithResponse => err
            puts err
        end

    end


    # TESTE - OK
    def impressaoCarne

        puts "Digite a Credencial. Ex: d3418668b85cea70aa28965eafaf927cd34d004c"
        credencial = gets.chomp
        puts "Digite a Chave. Ex: 46e79d6d5161336afa7b98f01236efacf5d0f24b"
        chave = gets.chomp
        
        puts "\n"

        puts "Array com número do pedido da cobrança. Ex: 8972"
        pedido_numero = gets.chomp


        puts "\nLoading...\n"

        begin
            response = RestClient::Request.execute(
                method: :post,
                url: "https://api.pjbank.com.br/recebimentos/#{credencial}/transacoes/lotes",
                headers: {
                    'x-chave': chave,
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                payload: {
                    pedido_numero: "#{pedido_numero}",
                    formato: "carne"
                }
            )

            puts response
        rescue RestClient::ExceptionWithResponse => err
            puts err
        end

    end

end