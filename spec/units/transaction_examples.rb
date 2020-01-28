shared_examples 'a transaction' do
  describe '#amount' do
    it 'should return the amount involved in the transaction' do
      expect(subject.amount).to eq 100
    end
  end

  describe '#date' do
    it 'should return the date the transaction occured' do
      expect(subject.date).to eq time
    end
  end

  describe "erroneous transactions" do
    it "should raise an error if a transaction has an amount of 0" do
      expect { described_class.new(0, time) }
        .to raise_error InvalidTransactionError, "Transaction must be greater than 0"
    end

    it "should raise an error if a transaction has a negative amount" do
      expect { described_class.new(-1, time) }
        .to raise_error InvalidTransactionError, "Transaction must be greater than 0"
    end
  end
end
