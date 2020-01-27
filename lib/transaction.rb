class Transaction
  attr_reader :type, :amount, :date

  def initialize(type, amount, date)
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
