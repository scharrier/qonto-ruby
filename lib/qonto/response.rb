module Qonto
  class Response
    attr_reader :http_response
    attr_reader :data

    def initialize(http_response, data)
      @http_response = http_response
      @data = data
    end

    def http_request
      http_response.request
    end
  end
end
