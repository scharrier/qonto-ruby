module Qonto
  module Model
    class BankAccount  < Base
      attr_accessor :slug
      attr_accessor :iban
      attr_accessor :bic
      attr_accessor :current
      attr_accessor :balance
      attr_accessor :balance_cents
    end
  end
end
