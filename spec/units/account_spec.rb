require 'account'

RSpec.describe Account do
  let(:transaction) { double :transaction }
  let(:transaction_class) { double :transaction_class, new: transaction }
  let(:statement_formatter) { double :statement_formatter, format: "Formatted statement" }

  subject { Account.new transaction_class, statement_formatter }

  describe '#deposit' do
    it "should return the current balance after 1 deposit" do
      expect(subject.deposit(400)).to eq 400
    end

    it "should return the current balance after 2 deposits" do
      subject.deposit(300)
      expect(subject.deposit(500)).to eq 800
    end

    it "should be creating a deposit" do
      Timecop.freeze Time.local(2017, 07, 29)

      expect(transaction_class).to receive(:new).with(:deposit, 250, Time.local(2017, 07, 29))
      subject.deposit(250)
    end
  end

  describe '#withdraw' do
    before { subject.deposit 1300 }

    it "should return the current balance after 1 withdrawal" do
      expect(subject.withdraw(400)).to eq 900
    end

    it "should return the current balance after 2 withdrawals" do
      subject.withdraw(300)
      expect(subject.withdraw(500)).to eq 500
    end

    it "should be creating a withdrawal" do
      Timecop.freeze Time.local(2017, 07, 29)

      expect(transaction_class).to receive(:new).with(:withdrawal, 250, Time.local(2017, 07, 29))
      subject.withdraw(250)
    end
  end

  describe '#statement' do
    it 'should pass an array of transactions to the statement formatter' do
      deposit_1 = double :deposit_1
      allow(transaction_class).to receive(:new).and_return(deposit_1)
      subject.deposit(1300)

      deposit_2 = double :deposit_2
      allow(transaction_class).to receive(:new).and_return(deposit_2)
      subject.deposit(300)

      withdrawal_1 = double :withdrawal_1
      allow(transaction_class).to receive(:new).and_return(withdrawal_1)
      subject.withdraw(600)

      expect(statement_formatter).to receive(:format).with([withdrawal_1, deposit_2, deposit_1], 1000)

      expect(subject.statement).to eq "Formatted statement"
    end
  end
end
