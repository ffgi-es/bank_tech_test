class Statement
  def self.format(transactions, balance)
    return 'Statement unavailable: no transactions have occured' if transactions.empty?

    statement = ["date || credit || debit || balance"]

    transactions.reduce(statement) do |lines, transaction|
      lines << handle_transaction(transaction, balance)
      balance = transaction.balance_before(balance)
      lines
    end.join("\n")
  end

  class << self
    private

    def handle_transaction(transaction, balance)
      line = transaction.date.strftime('%d/%m/%Y || ')
      case transaction.type
      when :deposit
        line << "%<amt>.2f || || %<bal>.2f" % { amt: transaction.amount, bal: balance }
      when :withdrawal
        line << "|| %<amt>.2f || %<bal>.2f" % { amt: transaction.amount, bal: balance }
      end
    end
  end
end
