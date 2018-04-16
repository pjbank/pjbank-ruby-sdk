require 'spec_helper'

RSpec.describe PJBank::Configuracao do
  it "uses production env by default" do
    expect(subject.env).to eql("production")
  end

  it "uses default user agent" do
    expect(subject.user_agent).to eql("pjbank-ruby-sdk/#{PJBank::VERSION}")
  end

  describe "#url" do
    context "when production env" do
      it "uses production url" do
        expect(subject.url).to eql("https://api.pjbank.com.br")
      end
    end

    context "when env other than production" do
      it "uses sandbox url" do
        subject.env = :anything
        expect(subject.url).to eql("https://sandbox.pjbank.com.br")
      end
    end
  end
end
