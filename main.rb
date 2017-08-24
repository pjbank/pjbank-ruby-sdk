require 'rest-client'

def credenciamento_conta_digital(nome_empresa)
    puts "\nLoading...\n"
    response = RestClient.post(
        'https://api.pjbank.com.br/contadigital/',
        {
            nome_empresa: nome_empresa,
            cnpj: "60285827000110",
            cep: '13032-525',
            endereco: 'endereco',
            numero: 'numero',
            bairro: 'bairro',
            complemento: '',
            cidade: 'cidade',
            estado: 'estado',
            ddd: '19',
            telefone: '81108110',
            email: 'email@ruby.com'
        }
    )

    puts response
end

def consulta_conta_digital(credencial, chave)
    puts "\nLoading...\n"
    response = RestClient::Request.execute(
        method: :get,
        url: 'https://api.pjbank.com.br/contadigital/'+credencial,
        headers: {
            'x-chave-conta': chave
        }
    )

    puts response
end

# eb2af021c5e2448c343965a7a80d7d090eb64164
# a834d47e283dd12f50a1b3a771603ae9dfd5a32c

puts "Digite sua ação:\n1 - Credenciamento de Conta Digital\n2 - Consulta Conta Digital"
acao = gets.chomp
case acao
    when '1' 
        puts "Nome da empresa. Ex: Exemplo Conta Digital"
        nome_empresa = gets.chomp
        # puts "CNPJ. Ex: 60285827000110"
        # cnpj = gets.chomp
        # puts "CEP. Ex: 13032-525"
        # cep = gets.chomp
        # puts "Endereço. Ex: Rua Joaquim Vilac"
        # endereco = gets.chomp
        # puts "Número. Ex: 509"
        # numero = gets.chomp
        # puts "Bairro. Ex: Vila Teixeira"
        # bairro = gets.chomp
        # puts "Complemento. Ex: (opcional)"
        # complemento = gets.chomp
        # puts "Cidade. Ex: Campinas"
        # cidade = gets.chomp
        # puts "Estado. Ex: SP"
        # estado = gets.chomp
        # puts "DDD. Ex: 19"
        # ddd = gets.chomp
        # puts "Telefone. Ex: 987652345"
        # telefone = gets.chomp
        # puts "E-mail. Ex: api@pjbank.com.br"
        # email = gets.chomp
        credenciamento_conta_digital nome_empresa
    when '2' 
        puts "Digite a Credencial (ex: eb2af021c5e2448c343965a7a80d7d090eb64164)"
        credencial = gets.chomp
        puts "\n"
        puts "Digite a Chave (ex: a834d47e283dd12f50a1b3a771603ae9dfd5a32c)"
        chave = gets.chomp
        puts "\n"
        consulta_conta_digital credencial, chave
end