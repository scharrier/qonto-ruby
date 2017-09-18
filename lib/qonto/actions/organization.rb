module Qonto
  module Actions
    module Organization
      def get_organization
        response = get("/organizations/#{configuration.get(:slug)}")
        modelize_organization(response.parsed_response['organization'])
      end

      private

      def modelize_organization(organization)
        if !organization['bank_accounts'].nil?
          organization['bank_accounts'] = modelize_bank_accounts(organization['bank_accounts'])
        end

        Qonto::Model::Organization.new(organization)
      end

      def modelize_bank_accounts(bank_accounts)
        bank_accounts.map do |bank_account|
          Qonto::Model::BankAccount.new(bank_account)
        end
      end
    end
  end
end
