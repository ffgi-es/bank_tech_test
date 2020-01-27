require 'withdrawal'
require_relative 'transaction_examples'

RSpec.describe Withdrawal do
  subject { Withdrawal.new(100, Time.parse("2019-03-08")) }

  it_behaves_like "a transaction"

  describe "#balance_after" do
    it "should return the balance after the transaction" do
      expect(subject.balance_after(400)).to eq 300
    end
  end

  describe "#balance_before" do
    it "should return the balance before the transaction" do
      expect(subject.balance_before(300)).to eq 400
    end
  end
end
