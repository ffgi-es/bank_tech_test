require 'transaction_log'

RSpec.describe TransactionLog do
  let(:transaction) { double :transaction }
  let(:transaction_class) { double :transaction_class, new: transaction }

  subject { TransactionLog.new(transaction_class) }

  after do
    Timecop.return
  end

  describe '#add_deposit' do
    it 'should return a transaction' do
      expect(subject.add_deposit 100).to eq transaction
    end

    it "should pass the correct details to create a transaction" do
      Timecop.freeze Time.local(2017, 07, 29)

      expect(transaction_class).to receive(:new)
        .with(:deposit, 250, Time.local(2017, 07, 29))

      subject.add_deposit(250)
    end
  end

  describe '#add_withdrawal' do
    it 'should return a transaction' do
      expect(subject.add_withdrawal 100).to eq transaction
    end

    it "should be creating a withdrawal" do
      Timecop.freeze Time.local(2017, 07, 29)

      expect(transaction_class).to receive(:new)
        .with(:withdrawal, 250, Time.local(2017, 07, 29))

      subject.add_withdrawal(250)
    end
  end

  describe '#transactions' do
    it 'should return an empty array if no transactions are logged' do
      expect(subject.transactions).to eq []
    end

    it 'should return the transactions in reverse order received' do
      deposit_1 = double :deposit_1
      deposit_2 = double :deposit_2
      withdrawal_1 = double :withdrawal_1
      deposit_3 = double :deposit_3

      transactions = [deposit_1, deposit_2, withdrawal_1, deposit_3]
        .each do |transaction|
        allow(transaction_class).to receive(:new).and_return transaction
        transaction == withdrawal_1 ? subject.add_withdrawal(100) : subject.add_deposit(100)
      end

      expect(subject.transactions).to eq transactions.reverse
    end
  end
end
