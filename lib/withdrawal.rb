class Withdrawal < Transaction
  def balance_before balance
    balance + @amount
  end

  def debit
    @amount
  end
end
