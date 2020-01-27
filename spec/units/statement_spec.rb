require 'statement'
require 'time'

RSpec.describe Statement do
  describe ".format" do
    let(:deposit_1) { double(:deposit_1, amount: 1000, date: Time.parse('2019-05-03'),
                             balance_before: 0) }
    let(:deposit_2) { double(:deposit_2, amount: 2000, date: Time.parse('2019-05-13'),
                             balance_before: 1000) }

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
  end
end
