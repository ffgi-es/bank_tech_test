class Account
  def initialize(statement_formatter = Statement, transaction_log = TransactionLog.new)
    @balance = 0
    @transaction_log = transaction_log

    @statement_formatter = statement_formatter
  end

  def deposit amount
    @transaction_log.add_deposit amount
    @balance += amount
  end

  def withdraw amount
    raise AccountError, "Insufficient funds" if (@balance - amount).negative?

    @transaction_log.add_withdrawal amount
    @balance -= amount
  end

  def print_statement
    puts @statement_formatter.format(@transaction_log, @balance)
  end
end

class AccountError < StandardError
end
