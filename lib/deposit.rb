require_relative 'transaction'

class Deposit < Transaction
  def balance_after balance_before
    balance_before + amount
  end

  def balance_before balance_after
    balance_after - amount
  end

  def type
    :deposit
  end
end
