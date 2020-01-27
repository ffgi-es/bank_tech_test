require 'transaction'
require 'time'

RSpec.describe Transaction do
  subject { Transaction.new(100, Time.parse("2019-06-13")) }

  describe "#amount" do
    it "should return the amount involved in the transaction" do
      expect(subject.amount).to eq 100
    end
  end
end
