require 'spec_helper'

RSpec.describe PJBank::Http do
  let(:credencial) { "1ab45dcc8" }
  let(:chave)      { "9c682cda1" }

  subject { described_class.new(credencial: credencial, chave: chave) }

  shared_examples "http method" do |method|
    before { PJBank.configuracao.user_agent = "my app/1.5.2" }

    it "sends a #{method.to_s.upcase} request to API" do
      expect(RestClient::Request).to receive(:execute).
        with(
          method: method,
          url: "https://sandbox.pjbank.com.br/resource/1ab45dcc8/nested_resource",
          headers: {
            "Content-Type" => "application/json",
            "X-CHAVE"      => "9c682cda1",
            "User-Agent"   => "my app/1.5.2",
          }
        ).and_return(double(body: '{"status":200}'))

      subject.send(method, "/resource/:credencial/nested_resource")
    end
  end

  %i[get post put delete].each do |method|
    describe "##{method.to_s}" do
      it_behaves_like "http method", method
    end
  end
end
