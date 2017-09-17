module Qonto
  class Error < StandardError
    NET_HTTP_ERRORS = [
      EOFError,
      Errno::ECONNABORTED,
      Errno::ECONNREFUSED,
      Errno::ECONNRESET,
      Errno::EHOSTUNREACH,
      Errno::EINVAL,
      Errno::ENETUNREACH,
      Net::HTTPBadResponse,
      Net::HTTPHeaderSyntaxError,
      Net::ProtocolError,
      Net::OpenTimeout,
      Net::ReadTimeout,
      SocketError,
      Zlib::GzipFile::Error,
      OpenSSL::SSL::SSLError
    ]

    attr_reader :http_response

    def initialize(response = nil)
      @http_response = response
      super(build_error_message)
    end

    def http_request
      http_response.request
    end

    private

    def build_error_message
      return nil if http_response.nil?

      message = "#{http_request_method} "
      message << "#{http_request.path} : "
      message << "#{http_response.code} - "
      message << response_message unless response_message.nil?
      message
    end

    def http_request_method
      http_request.http_method.name.split('::').last.upcase
    end

    def response_message
      content_type = http_response.headers['Content-Type']
      if content_type && content_type.start_with?('application/json')
        http_response.parsed_response['message']
      else
        net_http_response = http_response.response
        "#{net_http_response.code} #{net_http_response.message}"
      end
    end
  end

  # Raised on errors in the 400-499 range
  class ResponseError < Error; end

  # Raised when the API returns a 400 HTTP status code
  class BadRequestError < ResponseError; end

  # Raised when the API returns a 401 HTTP status code
  class AuthenticationError < ResponseError; end

  # Raised when the API returns a 402 HTTP status code
  class PaymentRequiredError < ResponseError; end

  # Raised when the API returns a 404 HTTP status code
  class NotFoundError < ResponseError; end

  # Raised on errors in the 500-599 range
  class ServerError < Error; end

  # Raised when the API returns a 500 HTTP status code
  class InternalServerError < ServerError; end

  # Raised when we can't establish a connection to the API or if reading the reponse times out
  class ConnectionError < Error; end
end
