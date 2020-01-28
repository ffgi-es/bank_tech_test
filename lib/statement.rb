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
      line = date_column(transaction)
      line << credit_column(transaction)
      line << debit_column(transaction)
      line << balance_column(balance)
    end

    def date_column transaction
      transaction.date.strftime('%d/%m/%Y') + ' || '
    end

    def credit_column transaction
      (transaction.credit ? "%<credit>.2f " % { credit: transaction.credit } : '') + '|| '
    end

    def debit_column transaction
      (transaction.debit ? "%<debit>.2f " % { debit: transaction.debit } : '') + '|| '
    end

    def balance_column balance
      "%<balance>.2f" % { balance: balance }
    end
  end
end
