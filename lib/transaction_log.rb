class TransactionLog
  attr_reader :transactions

  def initialize transaction_class = Transaction
    @transaction_class = transaction_class
    @transactions = []
  end

  def add_deposit amount
    @transactions.unshift @transaction_class.new(:deposit, amount, Time.now)
    @transactions.first
  end

  def add_withdrawal amount
    @transactions.unshift @transaction_class.new(:withdrawal, amount, Time.now)
    @transactions.first
  end
end
