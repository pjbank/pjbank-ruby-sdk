require 'rest-client'
require_relative 'lib/contadigital/contadigital'
require_relative 'lib/recebimento/recebimento'

contaController = ContaDigitalController.new
recebimentoController = RecebimentoController.new

puts "Digite sua ação:\n1 - Credenciamento\n2 - Transações"
acao = gets.chomp
case acao
    when '1'
        recebimentoController.credenciamento
    # when '1' 
    #     contaController.credenciamento
    # when '2'
    #     contaController.transacoes
    # when '3'
    #     contaController.subcontas
end