module Qonto
  class Configuration
    DEFAULTS = {
      base_url: 'https://thirdparty.qonto.eu/v1',
      user_agent: "qonto-api-ruby/#{VERSION}",
      slug: '',
      secret_key: ''
    }

    def initialize(configuration  = {})
      @configuration  = DEFAULTS.merge(configuration )
    end

    def get(key)
      @configuration [key]
    end
  end
end
