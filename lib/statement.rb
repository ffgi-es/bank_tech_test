module Statement
  def Statement.format(log, balance)
    return 'Statement unavailable: no transactions have occured' if log.transactions.empty?

    statement = ["date || credit || debit || balance"] + process(log, balance)

    statement.join("\n")
  end

  class << self
    private

    def process(log, balance)
      log.transactions.reduce([]) do |lines, transaction|
        lines << handle_transaction(transaction, balance)
        balance = transaction.balance_before(balance)
        lines
      end
    end

    def handle_transaction(transaction, balance)
      line = transaction.date.strftime('%d/%m/%Y') + ' || '
      case transaction.type
      when :deposit
        line << "%<amt>.2f || || %<bal>.2f" % { amt: transaction.amount, bal: balance }
      when :withdrawal
        line << "|| %<amt>.2f || %<bal>.2f" % { amt: transaction.amount, bal: balance }
      end
    end
  end
end
