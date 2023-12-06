module Qonto
  module Model
    class Transaction < Base
			attr_accessor :transaction_id
      attr_accessor :amount
      attr_accessor :amount_cents
      attr_accessor :settled_balance
      attr_accessor :settled_balance_cents
      attr_accessor :attachment_ids
			attr_accessor :local_amount
      attr_accessor :local_amount_cents
			attr_accessor :side
			attr_accessor :operation_type
      attr_accessor :currency
      attr_accessor :local_currency
			attr_accessor :label
			attr_accessor :settled_at
      attr_accessor :emitted_at
      attr_accessor :updated_at
			attr_accessor :status
      attr_accessor :note
      attr_accessor :reference
      attr_accessor :vat_amount
      attr_accessor :vat_amount_cents
      attr_accessor :vat_rate
      attr_accessor :initiator_id
      attr_accessor :label_ids
      attr_accessor :attachment_lost
      attr_accessor :attachment_required
      attr_accessor :card_last_digits
      attr_accessor :category
      attr_accessor :id
    end
  end
end
