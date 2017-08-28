require 'rest-client'
require_relative 'lib/contadigital/contadigital'
require_relative 'lib/recebimento/recebimento'

contaController = ContaDigitalController.new
recebimentoController = RecebimentoController.new

puts "Escolha o serviço:\n1 - Recebimento\n2 - Conta Digital"
acao = gets.chomp
case acao
    when '1'
        recebimentoController.credenciamento
    when '2' 
        contaController.credenciamento
    # when '2'
    #     contaController.transacoes
    # when '3'
    #     contaController.subcontas
end