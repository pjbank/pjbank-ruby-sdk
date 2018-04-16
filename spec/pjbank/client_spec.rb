require 'spec_helper'

RSpec.describe PJBank::Client do
  describe "#recebimentos" do
    it "returns an instance of PJBank::Recebimento::Controller" do
      expect(subject.recebimentos).to be_a(PJBank::Recebimento::Controller)
    end
  end
end
