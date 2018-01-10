module PJBank
  class Configuracao
    attr_accessor :env

    def initialize
      @env = "production"
    end

    def url
      env == "production" ? "https://api.pjbank.com.br" : "https://sandbox.pjbank.com.br"
    end
  end
end
