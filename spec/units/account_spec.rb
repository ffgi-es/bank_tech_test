require 'account'

RSpec.describe Account do
  let(:transaction_log) { double :transaction_log, add_deposit: nil, add_withdrawal: nil }
  let(:statement_formatter) { double :statement_formatter, format: "Formatted statement" }

  subject { Account.new statement_formatter, transaction_log }

  describe '#deposit' do
    it "should return the current balance after 1 deposit" do
      expect(subject.deposit(400)).to eq 400
    end

    it "should return the current balance after 2 deposits" do
      subject.deposit(300)
      expect(subject.deposit(500)).to eq 800
    end

    it 'should add the deposit to the log' do
      expect(transaction_log).to receive(:add_deposit)
        .with(250)
      subject.deposit(250)
    end
  end

  describe '#withdraw' do
    before { subject.deposit 1300 }

    it "should return the current balance after 1 withdrawal" do
      expect(subject.withdraw(400)).to eq 900
    end

    it "should return the current balance after 2 withdrawals" do
      subject.withdraw(300)
      expect(subject.withdraw(500)).to eq 500
    end

    it "should raise an error if not enough money is available" do
      expect { subject.withdraw(1301) }.to raise_error AccountError, "Insufficient funds"
    end

    it 'should add the withdrawal to the log' do
      expect(transaction_log).to receive(:add_withdrawal)
        .with(250)
      subject.withdraw(250)
    end
  end

  describe '#statement' do
    it 'should pass an array of transactions to the statement formatter' do
      subject.deposit(1300)
      subject.deposit(300)
      subject.withdraw(600)

      expect(statement_formatter).to receive(:format).with(transaction_log, 1000)

      expect { subject.print_statement }.to output(/Formatted statement/).to_stdout
    end
  end
end
