require 'spec_helper'

describe Qonto::Configuration do
  describe 'initialization' do
    it 'sets default values' do
      configuration = Qonto::Configuration.new

      expect(configuration.get(:base_url)).to eq('https://thirdparty.qonto.eu/v1')
      expect(configuration.get(:slug)).to eq('')
    end

    it 'overrides default values with given configuration' do
      configuration = Qonto::Configuration.new(slug: 'it-ducks', secret_key: 'quack')

      expect(configuration.get(:slug)).to eq('it-ducks')
      expect(configuration.get(:secret_key)).to eq('quack')
    end
  end
end
