require 'statement'

RSpec.describe Statement do
  describe ".format" do
    let(:deposit_1) do
      double(:deposit_1, type: :deposit, amount: 1000,
             date: double(:time_1, strftime: '03/05/2019'),
             balance_before: 0)
    end
    let(:deposit_2) do
      double(:deposit_2, type: :deposit, amount: 2000, 
             date: double(:time_2, strftime: '13/05/2019'),
             balance_before: 1000) 
    end
    let(:withdrawal_1) do
      double(:withdrawal_1, type: :withdrawal, amount: 500, 
             date: double(:time_3, strftime: '14/05/2019'),
             balance_before: 3000) 
    end
    let(:log) { double :transaction_log, transactions: [] }

    it "should return no statement if no transactions have occured" do
      expect(Statement.format(log, 0)).to eq 'Statement unavailable: no transactions have occured'
    end

    it "should return a formatted statement with a deposit" do
      allow(log).to receive(:transactions).and_return [deposit_1]
      expected_statement = "date || credit || debit || balance\n"
      expected_statement << "03/05/2019 || 1000.00 || || 1000.00"
      expect(Statement.format(log, 1000)).to eq expected_statement
    end

    it "should return a formatted statement with two deposits" do
      allow(log).to receive(:transactions).and_return [deposit_2, deposit_1]
      expected_statement = "date || credit || debit || balance\n"
      expected_statement << "13/05/2019 || 2000.00 || || 3000.00\n"
      expected_statement << "03/05/2019 || 1000.00 || || 1000.00"
      
      expect(Statement.format(log, 3000)).to eq expected_statement
    end

    it "should return a formatted statement with withdrawals as well" do
      allow(log).to receive(:transactions).and_return [withdrawal_1, deposit_2, deposit_1]
      expected_statement = "date || credit || debit || balance\n"
      expected_statement << "14/05/2019 || || 500.00 || 2500.00\n"
      expected_statement << "13/05/2019 || 2000.00 || || 3000.00\n"
      expected_statement << "03/05/2019 || 1000.00 || || 1000.00"

      expect(Statement.format(log, 2500)).to eq expected_statement
    end
  end
end
