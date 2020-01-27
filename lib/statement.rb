class Statement
  def self.format(transactions, balance)
    return 'Statement unavailable: no transactions have occured' if transactions.empty?

    statement = ["date || credit || debit || balance"]

    transactions.reduce(statement) do |statement, transaction|
      statement << handle_transaction(transaction, balance)
      balance = transaction.balance_before(balance)
      statement
    end.join("\n")
  end

  class << self
    private

    def handle_transaction(transaction, balance)
      line = transaction.date.strftime('%d/%m/%Y || ')
      case transaction.type
      when :deposit
        line << "%.2f || || %.2f" % [transaction.amount, balance]
      when :withdrawal
        line << "|| %.2f || %.2f" % [transaction.amount, balance]
      end
    end
  end
end
