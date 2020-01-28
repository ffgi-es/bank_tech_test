require 'transaction'
require 'withdrawal'

RSpec.describe Withdrawal do
  let(:time) { double :time }

  subject { Withdrawal.new(100, time) }

  it_behaves_like 'a transaction'

  describe "#balance_before" do
    it "should return the balance before the transaction" do
      expect(subject.balance_before(300)).to eq 400
    end
  end

  describe "#debit" do
    it 'should return the amount of debited by the withdrawal' do
      expect(subject.debit).to eq 100
    end
  end
end
