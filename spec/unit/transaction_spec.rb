require 'transaction'
require 'time'

RSpec.describe Transaction do
  subject { Transaction.new(100, Time.parse("2019-06-13")) }

  describe "#amount" do
    it "should return the amount involved in the transaction" do
      expect(subject.amount).to eq 100
    end
  end

  describe "#date" do
    it "should return the date the transaction occured" do
      expect(subject.date).to eq Time.parse("2019-06-13")
    end
  end
end
