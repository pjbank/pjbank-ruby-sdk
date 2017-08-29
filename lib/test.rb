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
                'dadosn': 'teste', 
                'dadost': 'teste2'
            }
        )
    when '2'
        PJBank::Recebimento.boleto(
            acao: :emitir, 
            dados: {
                'dadosn': 'teste3', 
                'dadost': 'teste4'
            }
        )
    when '3'
        PJBank::Recebimento.boleto(
            acao: :impressaoLote, 
            dados: {
                'dadosn': 'teste5', 
                'dadost': 'teste6'
            }
        )
    when '4'
        PJBank::Recebimento.boleto(
            acao: :impressaoCarne, 
            dados: {
                'dadosn': 'teste7', 
                'dadost': 'teste8'
            }
        )
end