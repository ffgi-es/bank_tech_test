require 'transaction'

RSpec.describe Transaction do
  let(:time) { double :time }

  subject { Transaction.new(100, time) }

  it_behaves_like 'a transaction'

  describe '#credit' do
    it 'should return nil' do
      expect(subject.credit).to be_nil
    end
  end

  describe '#debit' do
    it 'should return nil' do
      expect(subject.debit).to be_nil
    end
  end
end
