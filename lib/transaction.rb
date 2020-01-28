class Transaction
  attr_reader :type, :amount, :date

  def initialize(type, amount, date)
    raise InvalidTransactionError, "Transaction must be greater than 0" if amount <= 0

    @type = type
    @amount = amount
    @date = date
  end

  def balance_after balance_before
    case type
    when :deposit then balance_before + amount
    when :withdrawal then balance_before - amount
    end
  end

  def balance_before balance_after
    case type
    when :deposit then balance_after - amount
    when :withdrawal then balance_after + amount
    end
  end
end

class InvalidTransactionError < StandardError
end
