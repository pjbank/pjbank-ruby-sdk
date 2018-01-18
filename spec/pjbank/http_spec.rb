require 'spec_helper'

RSpec.describe PJBank::Http do
  let(:credencial) { "1ab45dcc8" }
  let(:chave)      { "9c682cda1" }

  subject { described_class.new(credencial: credencial, chave: chave) }

  shared_examples "http method" do |method|
    before { PJBank.configuracao.user_agent = "my app/1.5.2" }

    it "sends a #{method.to_s.upcase} request to API with correct url and headers" do
      expect(RestClient::Request).to receive(:execute).
        with(
          method: method,
          url: "https://sandbox.pjbank.com.br/resource/1ab45dcc8/nested_resource",
          headers: {
            "Content-Type" => "application/json",
            "X-CHAVE"      => "9c682cda1",
            "User-Agent"   => "my app/1.5.2",
            params:        {},
          }
        ).and_return(double(code: 200, body: '{"status":200}'))

      subject.send(method, "/resource/:credencial/nested_resource")
    end

    context "when sends a successfully #{method.to_s.upcase} request to API" do
      it "returns an object that responds for the body attributes" do
        expect(RestClient::Request).to receive(:execute).with(hash_including(method: method)).
          and_return(double(code: 200, body: '{"status":200,"msg":"Sucesso."}'))

        result = subject.send(method, "/resource")
        expect(result).to be_a(OpenStruct)
        expect(result.status).to eql(200)
        expect(result.msg).to eql("Sucesso.")
      end
    end

    context "when sends a failure #{method.to_s.upcase} request to API" do
      let(:response) { OpenStruct.new(code: 500, body: '{"status":500,"msg":"Alguma falha de validação."}') }

      it "raises PJBank::RequestError" do
        expect(RestClient::Request).to receive(:execute).with(hash_including(method: method)).
          and_raise(RestClient::ExceptionWithResponse.new(response))

        expect { subject.send(method, "/resource") }.to raise_error do |error|
          expect(error).to be_a(PJBank::RequestError)
          expect(error.code).to eql(500)
          expect(error.message).to eql("Alguma falha de validação.")
          expect(error.body).to eql({ "status" => 500, "msg" => "Alguma falha de validação." })
        end
      end
    end

    context "when :params option is given" do
      it "returns an object that responds for the body attributes" do
        expect(RestClient::Request).to receive(:execute).with(
            hash_including(headers: hash_including(params: { data_inicio: "19/05/2018" }))
          ).
          and_return(double(code: 200, body: '{"status":200,"msg":"Sucesso."}'))

        result = subject.send(method, "/resource", params: { data_inicio: "19/05/2018" } )
        expect(result).to be_a(OpenStruct)
        expect(result.status).to eql(200)
        expect(result.msg).to eql("Sucesso.")
      end
    end
  end

  %i[get post put delete].each do |method|
    describe "##{method.to_s}" do
      it_behaves_like "http method", method
    end
  end
end
