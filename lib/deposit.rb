require_relative 'transaction'

class Deposit < Transaction
  def balance_after balance_before
    balance_before + self.amount
  end
end
