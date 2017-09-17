module Qonto
  module Model
    class Organization  < Base
      attr_accessor :slug
      attr_accessor :bank_accounts

      def initialize(attributes)
        if !attributes['bank_accounts'].nil?
          attributes['bank_accounts'] = modelize_bank_accounts(attributes['bank_accounts'])
        end

        super(attributes)
      end

      private

      def modelize_bank_accounts(bank_accounts)
        bank_accounts.map do |bank_account|
          Qonto::Model::BankAccount.new(bank_account)
        end
      end
    end
  end
end
