require 'bank'

RSpec.describe 'invalid operations' do
  let(:account) { Account.new }

  after do
    Timecop.return
  end

  it 'should not allow negative deposits' do
    expect { account.deposit(-1) }
      .to raise_error InvalidTransactionError, "Transaction must be greater than 0"
  end

  it 'should not allow negative withdrawals' do
    account.deposit 300
    expect { account.withdraw(-200) }
      .to raise_error InvalidTransactionError, "Transaction must be greater than 0"
  end

  it 'should not allow more money than available to be withdrawn' do
    account.deposit 200
    expect { account.withdraw 203 }
      .to raise_error AccountError, "Insufficient funds"
  end

  it 'should not affect the final statement' do
    Timecop.freeze Time.local(2019, 5, 11)
    account.deposit(2300)
    
    Timecop.freeze Time.local(2019, 5, 12)
    account.deposit(-12)
  rescue InvalidTransactionError

    Timecop.freeze Time.local(2019, 5, 13)
    account.withdraw(400)
    Timecop.freeze Time.local(2019, 5, 17)
    account.withdraw(700)

    expected_statement = "date || credit || debit || balance\n"
    expected_statement << "17/05/2019 || || 700.00 || 1200.00\n"
    expected_statement << "13/05/2019 || || 400.00 || 1900.00\n"
    expected_statement << "11/05/2019 || 2300.00 || || 2300.00"

    expect(account.statement).to eq expected_statement
  end
end
