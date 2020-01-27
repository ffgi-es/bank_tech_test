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
  end

  describe '#statement' do
    it 'should pass an array of transactions to the statement formatter' do
      subject.deposit(1300)
      subject.deposit(300)

      expect(statement_formatter).to receive(:format).with([transaction, transaction], 1600)

      expect(subject.statement).to eq "Formatted statement"
    end
  end
end
