require './pjbank-ruby-sdk.rb'

puts "Testes: "
puts "1 - Recebimento/Boleto/Credenciamento"
puts "2 - Recebimento/Boleto/Emitir"
puts "3 - Recebimento/Boleto/Impressão em Lotes"
puts "4 - Recebimento/Boleto/Impressão de Carnê"

teste = gets.chomp

case teste
    when '1'
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
    when '2'
        PJBank::Recebimento.boleto(
            acao: :emitir, 
            aut: {
                'credencial': 'd3418668b85cea70aa28965eafaf927cd34d004c',
            },
            dados: {
                vencimento: "12/30/2019",
                valor: "1000.98",
                juros: "0.0",
                multa: "0.98",
                desconto: " 9.58",
                nome_cliente: "Cliente de exemplo",  
                cpf_cliente: "62936576000112",  
                endereco_cliente: "Rua Joaquim Vilac",  
                numero_cliente: 509,  
                complemento_cliente: "",  
                bairro_cliente: "Vila Teixeira",  
                cidade_cliente: "Campinas",  
                estado_cliente: "SP",  
                cep_cliente: "13301510",  
                logo_url: "http://wallpapercave.com/wp/xK64fR4.jpg",
                texto: "",
                grupo: "Boletos001",
                pedido_numero: "8972"
            }
        )
    when '3'
        PJBank::Recebimento.boleto(
            acao: :impressaoLote,
            aut: {
                'credencial': 'd3418668b85cea70aa28965eafaf927cd34d004c',
                'chave': '46e79d6d5161336afa7b98f01236efacf5d0f24b'
            },
            dados: {
                pedido_numero: 8972,
                # formato: "carne"
            }
        )
    when '4'
        PJBank::Recebimento.boleto(
            acao: :impressaoCarne, 
            aut: {
                'credencial': 'd3418668b85cea70aa28965eafaf927cd34d004c',
                'chave': '46e79d6d5161336afa7b98f01236efacf5d0f24b'
            },
            dados: {
                pedido_numero: 8972,
                formato: "carne"
            }
        )
end