require 'ostruct'
require 'json'

module PJBank
  RequestError = Class.new(Exception)
  RequestTimeout = Class.new(Exception)

  class Http
    attr_reader :chave, :credencial

    def initialize(chave: nil, credencial: nil)
      @chave      = chave
      @credencial = credencial
    end

    %i[get post delete put].each do |m|
      define_method(m) do |path, options={}|
        send_request(m, path, options)
      end
    end

    private

    # TODO: refatorar esse método quando TODOS testes estiverem rodando sem problema.
    def send_request(method, path, options)
      options[:payload] = options[:payload].to_json if options[:payload]
      query_params = options.delete(:params) || {}

      response = RestClient::Request.execute(options.merge!({
        method:  method,
        url:     "#{PJBank.configuracao.url}#{path}".gsub(':credencial', credencial.to_s),
        headers: {
          "Content-Type" => "application/json",
          "X-CHAVE"      => chave,
          "User-Agent"   => PJBank.configuracao.user_agent,
          params:           query_params,
        }
      }))

      OpenStruct.new(JSON.parse(response.body))

      rescue RestClient::GatewayTimeout, RestClient::Exceptions::Timeout
        raise RequestTimeout
      rescue RestClient::ExceptionWithResponse => e
        error!(e.response)
    end

    def error!(response)
      body = JSON.parse(response.body) rescue {}
      raise RequestError.new(
        code:    response.code,
        message: body["msg"],
        body:    body
      )
    end
  end
end
