require 'bank'

RSpec.describe 'depositing into account' do
  let(:account) { Account.new }

  after do
    Timecop.return
  end

  it "should return the current balance" do
    expect(account.deposit(500)).to eq 500
    expect(account.deposit(300)).to eq 800
  end

  it "should record transactions for a statement" do
    Timecop.freeze Time.local(2019, 8, 17)
    account.deposit 400
    Timecop.freeze Time.local(2019, 8, 19)
    account.deposit 700

    expected_statement = "date || credit || debit || balance\n"
    expected_statement << "19/08/2019 || 700.00 || || 1100.00\n"
    expected_statement << "17/08/2019 || 400.00 || || 400.00"

    expect(account.statement).to eq expected_statement
  end
end
