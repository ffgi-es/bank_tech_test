require 'transaction'
require 'deposit'

RSpec.describe Deposit do
  let(:time) { double :time }

  subject { Deposit.new(100, time) }

  it_behaves_like 'a transaction'

  describe "#balance_before" do
    it "should return the balance before the transaction" do
      expect(subject.balance_before(500)).to eq 400
    end
  end

  describe "#credit" do
    it "should return the amount credited by the deposit" do
      expect(subject.credit).to eq 100
    end
  end
end
