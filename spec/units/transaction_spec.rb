require 'transaction'
require 'time'

shared_examples 'a transaction' do
  describe '#amount' do
    it 'should return the amount involved in the transaction' do
      expect(subject.amount).to eq 100
    end
  end

  describe '#date' do
    it 'should return the date the transaction occured' do
      expect(subject.date).to eq Time.parse('2019-05-13')
    end
  end
end

RSpec.describe Transaction do
  describe ':deposit' do
    subject { Transaction.new(:deposit, 100, Time.parse('2019-05-13')) }

    it_behaves_like 'a transaction'

    describe "#type" do
      it "should return :deposit" do
        expect(subject.type).to eq :deposit
      end
    end

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
  end

  describe ':withdrawal' do
    subject { Transaction.new(:withdrawal, 100, Time.parse('2019-05-13')) }

    it_behaves_like 'a transaction'

    describe "#type" do
      it "should return withdrawal" do
        expect(subject.type).to eq :withdrawal
      end
    end

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
end
