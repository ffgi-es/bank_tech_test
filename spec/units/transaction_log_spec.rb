require 'transaction_log'

RSpec.describe TransactionLog do
  let(:deposit) { double :deposit }
  let(:deposit_class) { double :deposit_class, new: deposit }
  let(:withdrawal) { double :withdrawal }
  let(:withdrawal_class) { double :withdrawal_class, new: withdrawal }
  let(:time) { double :time }
  let(:time_class) { double :Time, now: time }

  subject { TransactionLog.new(deposit_class, withdrawal_class, time_class) }

  describe '#add_deposit' do
    it 'should return a transaction' do
      expect(subject.add_deposit 100).to eq deposit
    end

    it "should pass the correct details to create a transaction" do
      expect(deposit_class).to receive(:new)
        .with(250, time)

      subject.add_deposit(250)
    end
  end

  describe '#add_withdrawal' do
    it 'should return a transaction' do
      expect(subject.add_withdrawal 100).to eq withdrawal
    end

    it "should be creating a withdrawal" do
      expect(withdrawal_class).to receive(:new)
        .with(250, time)

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
      withdrawal_2 = double :withdrawal_2

      allow(deposit_class).to receive(:new).and_return(deposit_1, deposit_2, deposit_3)
      allow(withdrawal_class).to receive(:new).and_return(withdrawal_1, withdrawal_2)

      subject.add_deposit 100
      subject.add_deposit 200
      subject.add_withdrawal 100
      subject.add_deposit 300
      subject.add_withdrawal 200

      expected_array = [
        withdrawal_2,
        deposit_3,
        withdrawal_1,
        deposit_2,
        deposit_1
      ]

      expect(subject.transactions).to eq expected_array
    end
  end
end
