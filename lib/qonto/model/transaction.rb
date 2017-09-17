module Qonto
  module Model
    class Transaction < Base
      attr_accessor :amount
      attr_accessor :amount_cents
      attr_accessor :local_amount
      attr_accessor :local_amount_cents
      attr_accessor :side
      attr_accessor :operation_type
      attr_accessor :currency
      attr_accessor :local_currency
      attr_accessor :settled_at
      attr_accessor :label
    end
  end
end
