require_relative 'transaction'

class Withdrawal < Transaction
  def balance_after balance_before
    balance_before - self.amount
  end

  def balance_before balance_after
    balance_after + self.amount
  end

  def type
    :withdrawal
  end
end
