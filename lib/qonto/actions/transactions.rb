module Qonto
  module Actions
    module Transactions
      def list_transactions(bank_account:)
        response = get("/transactions?slug=#{bank_account.slug}&iban=#{bank_account.iban}")
        Qonto::Response.new(response, modelize_transactions(response.parsed_response['transactions']))
      end

      private

      def modelize_transactions(transactions)
        transactions.map do |transaction|
          Qonto::Model::Transaction.new(transaction)
        end
      end
    end
  end
end
