require 'statement'
require 'time'

RSpec.describe Statement do
  describe ".format" do
    let(:deposit_1) do
      double(:deposit_1, type: :deposit, amount: 1000, date: Time.parse('2019-05-03'),
             balance_before: 0)
    end
    let(:deposit_2) do
      double(:deposit_2, type: :deposit, amount: 2000, date: Time.parse('2019-05-13'),
             balance_before: 1000) 
    end
    let(:withdrawal_1) do
      double(:withdrawal_1, type: :withdrawal, amount: 500, date: Time.parse('2019-05-14'),
             balance_before: 3000) 
    end

    it "should return no statement if no transactions have occured" do
      expect(Statement.format([], 0)).to eq 'Statement unavailable: no transactions have occured'
    end

    it "should return a formatted statement with a deposit" do
      transactions = [deposit_1]
      expected_statement = "date || credit || debit || balance\n"
      expected_statement << "03/05/2019 || 1000.00 || || 1000.00"
      expect(Statement.format(transactions, 1000)).to eq expected_statement
    end

    it "should return a formatted statement with two deposits" do
      transactions = [deposit_2, deposit_1]
      expected_statement = "date || credit || debit || balance\n"
      expected_statement << "13/05/2019 || 2000.00 || || 3000.00\n"
      expected_statement << "03/05/2019 || 1000.00 || || 1000.00"
      
      expect(Statement.format(transactions, 3000)).to eq expected_statement
    end

    it "should return a formatted statement with withdrawals as well" do
      transactions = [withdrawal_1, deposit_2, deposit_1]
      expected_statement = "date || credit || debit || balance\n"
      expected_statement << "14/05/2019 || || 500.00 || 2500.00\n"
      expected_statement << "13/05/2019 || 2000.00 || || 3000.00\n"
      expected_statement << "03/05/2019 || 1000.00 || || 1000.00"

      expect(Statement.format(transactions, 2500)).to eq expected_statement
    end
  end
end
