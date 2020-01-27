require 'deposit'
require_relative 'transaction_examples'

RSpec.describe Deposit do
  subject { Deposit.new(100, Time.parse("2019-11-21")) }

  it_behaves_like "a transaction"

  describe "#balance_after" do
    it "should return the balance after the transaction" do
      expect(subject.balance_after(400)).to eq 500
    end
  end

  describe "#balance_before" do
    it "should return the balance before the transaction" do
      expect(subject.balance_before(500)).to eq 400
    end
  end

  describe "#type" do
    it "should return :deposit" do
      expect(subject.type).to eq :deposit
    end
  end
end
