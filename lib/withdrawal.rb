require_relative 'transaction'

class Withdrawal < Transaction
  def balance_after balance_before
    balance_before - amount
  end

  def balance_before balance_after
    balance_after + amount
  end

  def type
    :withdrawal
  end
end
