# Bank Tech Test

## Description

A command line program run on the ruby REPL to keep track of a
bank accounts transactions and provide a simple formatted
statement.

## Usage

### Installation

Clone this repo and install the ruby gems:
```
$ git clone git@github.com:ffgi-es/bank_tech_test.git
$ cd bank_tech_test
$ bundle install
```

### Running Tests

Run the tests with RSpec and Rubocop in the root project directory:
```
$ rspec
$ rubocop
```
This should show all tests passing, 100% test coverage and no
offenses for rubocop

### Running the program

Open irb in the root project folder.
All library files can be loaded by `require_relative 'lib/bank'`.
You can then create a new account, deposit and withdraw money and
retreive a statement
```
$ irb
2.6.5 :001 > account = Account.new
=> #<Account:0x000055fcae90fed8 @balance=0, @transaction_log=#<TransactionLog:0x000055fcae90feb0 @transaction_class=Transaction, @transactions=[]>, @statement_formatter=Statement>
2.6.5 :002 > account.deposit(1000)
=> 1000
2.6.5 :003 > account.deposit(300)
=> 1300
2.6.5 :004 > account.withdraw(54.23)
=> 1245.77
2.6.5 :005 > account.withdraw(220)
=> 1025.77
2.6.5 :006 > account.print_statement
date || credit || debit || balance
28/01/2020 || || 220.00 || 1025.77
28/01/2020 || || 54.23 || 1245.77
28/01/2020 || 300.00 || || 1300.00
28/01/2020 || 1000.00 || || 1000.00
=> nil
```

## Approach

### Class structure

This solution has 4 separate parts:

| Class | Responsibility |
|-|-|
| Account | Tracks the current balance (what the user interacts with) |
| TransactionLog | Stores a log of transactions |
| Transaction | Holds a single transaction's information |
| Deposit | Inherits Transaction, defines methods specfic for deposit |
| Withdrawal | Inherits Transactoin, defines methods specific for witdrawal |
| Statement | Takes a TransactionLog and current balance and returns a formatted statement string |

## Specification

### Requirements

* You should be able to interact with your code via a REPL like IRB or the JavaScript console.  (You don't need to implement a command line interface that takes input from STDIN.)
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2012  
**And** a deposit of 2000 on 13-01-2012  
**And** a withdrawal of 500 on 14-01-2012  
**When** she prints her bank statement  
**Then** she would see

```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```
