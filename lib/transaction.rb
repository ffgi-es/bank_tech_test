class Transaction
  attr_reader :amount, :date

  def initialize(amount, date)
    raise InvalidTransactionError, "Transaction must be greater than 0" if amount <= 0

    @amount = amount
    @date = date
  end

  def credit
  end

  def debit
  end
end

class InvalidTransactionError < StandardError
end
