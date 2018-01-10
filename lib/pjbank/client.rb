require_relative 'http'
require_relative 'contadigital/contadigital'
require_relative 'recebimento/controller'

module PJBank
  class Client
    attr_reader :http

    # TODO: ver se fica melhor possibilitando o recebimento dos dois pares chave/credencial para recebimento de cartão e
    # boleto sem conta digital de uma vez só, de modo que seja possível instanciar de uma só vez o client com tudo.
    #   - com conta digital: chave:, credencial:
    #   - sem conta digital: chave_boleto:, credencial_boleto:, chave_cartao:, credencial_cartao:
    # O problema é que na api de extrato vamos ter que indicar qual tipo de recebimento para pegar o par correto.
    def initialize(chave: nil, credencial: nil)
      @http = Http.new(chave: chave, credencial: credencial)
    end

    def recebimentos
      Recebimento::Controller.new(http)
    end
  end
end
