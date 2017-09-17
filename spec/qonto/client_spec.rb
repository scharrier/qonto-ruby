require 'spec_helper'

describe Qonto::Client do
  describe '#get_organization' do
    before do
      stub_request(:get, %r{/organizations})
        .to_return(read_http_fixture('get_organization/success.http'))
    end

    it 'builds the correct request' do
      client = described_class.new(slug: 'it-ducks', secret_key: '123')

      client.get_organization

      expect(WebMock).to have_requested(:get, 'https://thirdparty.qonto.eu/v1/organizations/it-ducks')
        .with(headers: {
          'Accept' => 'application/json',
          'Authorization' => 'it-ducks:123',
          'User-Agent' => "qonto-api-ruby/#{Qonto::VERSION}"
        })
    end

    it 'returns the correct response' do
      client = described_class.new(slug: 'it-ducks')

      response = client.get_organization

      expect(response).to be_a(Qonto::Response)
      expect(response.data).to be_a(Qonto::Model::Organization)
    end
  end

  describe '#list_transactions' do
    before do
      stub_request(:get, %r{/transactions})
        .to_return(read_http_fixture('list_transactions/success.http'))
    end

    it 'builds the correct request' do
      client = described_class.new(slug: 'it-ducks', secret_key: '123')
      account = Qonto::Model::BankAccount.new(slug: 'my-account', iban: '123456')
      client.list_transactions(bank_account: account)

      expect(WebMock).to have_requested(:get, 'https://thirdparty.qonto.eu/v1/transactions?iban=123456&slug=my-account')
        .with(headers: {
          'Accept' => 'application/json',
          'Authorization' => 'it-ducks:123',
          'User-Agent' => "qonto-api-ruby/#{Qonto::VERSION}"
        })
    end

    it 'returns the correct response' do
      client = described_class.new(slug: 'it-ducks')

      account = Qonto::Model::BankAccount.new(slug: 'my-account', iban: '123456')
      response = client.list_transactions(bank_account: account)

      expect(response).to be_a(Qonto::Response)
      expect(response.data.first).to be_a(Qonto::Model::Transaction)
    end
  end
end
