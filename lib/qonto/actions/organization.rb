module Qonto
  module Actions
    module Organization
      def get_organization
        response = get("/organizations/#{configuration.get(:slug)}")
        Qonto::Response.new(response, Model::Organization.new(response.parsed_response['organization']))
      end
    end
  end
end
