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

    def send_request(method, path, options)
      options[:payload] = options[:payload].to_json if options[:payload]

      execute_request(method, path, options) do |response|
        if response.is_a?(Array)
          response.map { |i| OpenStruct.new(i) }
        else
          OpenStruct.new(response)
        end
      end
    end

    def execute_request(method, path, options, &block)
      response = RestClient::Request.execute(prepare_request_options(method, path, options))

      yield(JSON.parse(response.body))

      rescue RestClient::GatewayTimeout, RestClient::Exceptions::Timeout
        raise RequestTimeout
      rescue RestClient::ExceptionWithResponse => e
        error!(e.response)
    end

    def prepare_request_options(method, path, options)
      deep_hash_merge(options, {
        method:  method,
        url:     define_url(path),
        headers: {
          "Content-Type" => "application/json",
          "X-CHAVE"      => chave,
          "User-Agent"   => PJBank.configuracao.user_agent,
        }
      })
    end

    def define_url(path)
      "#{PJBank.configuracao.url}#{path}".gsub(':credencial', credencial.to_s)
    end

    def error!(response)
      body = JSON.parse(response.body) rescue {}
      raise RequestError.new(
        code:    response.code,
        message: body["msg"] || body["message"],
        body:    body
      )
    end

    def deep_hash_merge(h1, h2)
      h1.merge(h2) { |key, h1_elem, h2_elem| deep_hash_merge(h1_elem, h2_elem) }
    end
  end
end
