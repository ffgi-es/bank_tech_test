require 'bank'

RSpec.describe 'withdrawing from account' do
  let(:account) { Account.new }

  after do
    Timecop.return
  end

  it 'should return the current balance' do
    account.deposit(3000)

    expect(account.withdraw(300)).to eq 2700
    expect(account.withdraw(1500)).to eq 1200
  end

  it "should record transactions for a statement" do
    Timecop.freeze Time.local(2019, 5, 11)
    account.deposit(2300)
    Timecop.freeze Time.local(2019, 5, 13)
    account.withdraw(400)
    Timecop.freeze Time.local(2019, 5, 17)
    account.withdraw(700)

    expected_statement = "date || credit || debit || balance\n"
    expected_statement << "17/05/2019 || || 700.00 || 1200.00\n"
    expected_statement << "13/05/2019 || || 400.00 || 1900.00\n"
    expected_statement << "11/05/2019 || 2300.00 || || 2300.00\n"

    expect { account.print_statement }.to output(expected_statement).to_stdout
  end
end
