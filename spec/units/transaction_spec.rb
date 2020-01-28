require 'transaction'

shared_examples 'a transaction' do |type|
  describe '#amount' do
    it 'should return the amount involved in the transaction' do
      expect(subject.amount).to eq 100
    end
  end

  describe '#date' do
    it 'should return the date the transaction occured' do
      expect(subject.date).to eq Time.local(2019, 05, 13)
    end
  end

  describe "erroneous transactions" do
    it "should raise an error if a transaction has an amount of 0" do
      expect { Transaction.new(type, 0, Time.local(2017, 03, 14)) }
        .to raise_error InvalidTransactionError, "Transaction must be greater than 0"
    end

    it "should raise an error if a transaction has a negative amount" do
      expect { Transaction.new(type, -1, Time.local(2017, 03, 14)) }
        .to raise_error InvalidTransactionError, "Transaction must be greater than 0"
    end
  end
end

RSpec.describe Transaction do
  describe ':deposit' do
    subject { Transaction.new(:deposit, 100, Time.local(2019, 05, 13)) }

    it_behaves_like 'a transaction', :deposit

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
    subject { Transaction.new(:withdrawal, 100, Time.local(2019, 05, 13)) }

    it_behaves_like 'a transaction', :withdrawal

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
