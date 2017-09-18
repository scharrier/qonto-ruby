module Qonto
  module Actions
    module Transactions
      def list_transactions(bank_account:, current_page: nil, per_page: nil)
        query = prepare_query_string(bank_account, current_page, per_page)
        response = get("/transactions?#{query}")

        Qonto::Response.new(response, modelize_transactions(response.parsed_response['transactions']))
      end

      private

      def prepare_query_string(bank_account, current_page, per_page)
        {
          slug: bank_account.slug,
          iban: bank_account.iban,
          current_page: current_page,
          per_page: per_page
        }.compact
         .map { |(key, value)| "#{key}=#{value}" }
         .join('&')
       end

      def modelize_transactions(transactions)
        transactions.map do |transaction|
          Qonto::Model::Transaction.new(transaction)
        end
      end
    end
  end
end
