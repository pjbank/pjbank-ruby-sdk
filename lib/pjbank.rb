require 'rest-client'

require 'pjbank/version'
require 'pjbank/exception'
require 'pjbank/configuracao'
require 'pjbank/client'

module PJBank
  def self.configuracao
    @configuracao ||= Configuracao.new
  end

  def self.configure
    yield(configuracao) if block_given?
  end

  class ContaDigital
    @@contaController = ContaDigitalController.new
  end
end
