class Deposit < Transaction
  def balance_before balance
    balance - @amount
  end

  def credit
    @amount
  end
end
