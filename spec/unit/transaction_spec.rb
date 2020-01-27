require 'transaction'
require_relative 'transaction_examples'

RSpec.describe Transaction do
  it_behaves_like "a transaction"
end
