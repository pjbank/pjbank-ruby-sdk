module PJBank
  class Configuracao
    attr_accessor :env, :user_agent

    def initialize
      @env        = "production"
      @user_agent = "pjbank-ruby-sdk/#{PJBank::VERSION}"
    end

    def url
      env == "production" ? "https://api.pjbank.com.br" : "https://sandbox.pjbank.com.br"
    end
  end
end
