class Account
  def initialize(transaction_class = Transaction, statement_formatter = Statement)
    @balance = 0
    @transactions = []

    @transaction_class = transaction_class
    @statement_formatter = statement_formatter
  end

  def deposit amount
    @transactions.unshift @transaction_class.new(:deposit, amount, Time.now)
    @balance += amount
  end

  def statement
    @statement_formatter.format(@transactions, @balance)
  end
end
