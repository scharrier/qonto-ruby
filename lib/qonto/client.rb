require 'httparty'
require 'qonto/actions'
require 'qonto/error'
require 'qonto/model'

module Qonto
  class Client
    include Qonto::Actions::Organization
    include Qonto::Actions::Transactions

    API_VERSION = 'v2'.freeze
    BASE_URL = 'https://thirdparty.qonto.eu/'.freeze
    USER_AGENT = "qonto-ruby/#{VERSION}".freeze

    def initialize(slug:, secret_key:)
      @slug = slug
      @secret_key = secret_key
    end

    def base_url
      "#{BASE_URL}#{API_VERSION}"
    end

    def get(path)
      execute :get, path
    end

    private

    attr_reader :slug, :secret_key

    def execute(method, path)
      begin
        response = request(method, path)
      rescue *Error::NET_HTTP_ERRORS => err
        raise ConnectionError.new, err.message
      end

      case response.code
      when 200..299
        response
      when 400
        raise BadRequestError.new(response)
      when 401
        raise AuthenticationError.new(response)
      when 404
        raise NotFoundError.new(response)
      when 400..499
        raise ResponseError.new(response)
      when 500
        raise InternalServerError.new(response)
      when 500..599
        raise ServerError.new(response)
      end
    end

    def request(method, path)
      HTTParty.send(method, base_url + path, base_options)
    end

    def base_options
      {
        format: :json,
        headers: {
          'Accept' => 'application/json',
          'Authorization' => "#{slug}:#{secret_key}",
          'User-Agent' => USER_AGENT
        }
      }
    end
  end
end
