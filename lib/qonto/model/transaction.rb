module Qonto
  module Model
    class Transaction < Base
      attr_accessor :amount
      attr_accessor :amount_cents
      attr_accessor :currency
      attr_accessor :emitted_at
      attr_accessor :label
      attr_accessor :local_amount
      attr_accessor :local_amount_cents
      attr_accessor :local_currency
      attr_accessor :note
      attr_accessor :operation_type
      attr_accessor :settled_at
      attr_accessor :side
      attr_accessor :status
      attr_accessor :transaction_id
      attr_accessor :vat_amount
      attr_accessor :vat_amount_cents
      attr_accessor :vat_rate
    end
  end
end
