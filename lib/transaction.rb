class Transaction
  attr_reader :amount

  def initialize(amount, date)
    @amount = amount
  end
end
