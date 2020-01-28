class TransactionLog
  attr_reader :transactions

  def initialize(deposit_class = Deposit, withdrawal_class = Withdrawal, time = Time)
    @deposit_class = deposit_class
    @withdrawal_class = withdrawal_class
    @time = time
    @transactions = []
  end

  def add_deposit amount
    @transactions.unshift @deposit_class.new(amount, @time.now)
    @transactions.first
  end

  def add_withdrawal amount
    @transactions.unshift @withdrawal_class.new(amount, @time.now)
    @transactions.first
  end
end
