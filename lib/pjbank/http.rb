require 'ostruct'
require 'json'

module PJBank
  class Http
    attr_reader :chave, :credencial

    def initialize(chave:, credencial:)
      @chave      = chave
      @credencial = credencial
    end

    %i[get post delete put].each do |m|
      define_method(m) do |path, options={}|
        send_request(m, path, options)
      end
    end

    private

    def send_request(method, path, options)
      response = RestClient::Request.execute(options.merge!({
        method:  method,
        url:     "#{PJBank.configuracao.url}#{path}".gsub(':credencial', credencial),
        headers: {
          "Content-Type": "application/json",
          "X-CHAVE":      chave,
        }
      }))
      # TODO: lidar com possíveis exceções
      OpenStruct.new(JSON.parse(response.body))
    end

  end
end
