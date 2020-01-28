class TransactionLog
  attr_reader :transactions

  def initialize(transaction_class = Transaction, time = Time)
    @transaction_class = transaction_class
    @time = time
    @transactions = []
  end

  def add_deposit amount
    @transactions.unshift @transaction_class.new(:deposit, amount, @time.now)
    @transactions.first
  end

  def add_withdrawal amount
    @transactions.unshift @transaction_class.new(:withdrawal, amount, @time.now)
    @transactions.first
  end
end
