require 'spec_helper'

describe Qonto::Client do
  describe '#get' do
    it 'sends the request with headers' do
      stub_request(:get, /success/)
      client = described_class.new(slug: 'it-ducks', secret_key: '123')

      client.get('/success')

      expect(WebMock).to have_requested(
        :get,
        'https://thirdparty.qonto.eu/v2/success'
      ).with(headers: {
        'Accept' => 'application/json',
        'Authorization' => 'it-ducks:123',
        'User-Agent' => "qonto-ruby/#{Qonto::VERSION}"
      })
    end

    it 'handles errors correctly and raise a custom error' do
      stub_request(:get, /unauthorized/)
        .to_return(read_http_fixture('unauthorized.http'))
      client = described_class.new(slug: 'it-ducks', secret_key: '123')

      expect do
        client.get('/unauthorized')
      end.to raise_error(Qonto::Error)
    end
  end

  describe '#get_organization' do
    before do
      stub_request(:get, %r{/organizations})
        .to_return(read_http_fixture('get_organization/success.http'))
    end

    it 'builds the correct request' do
      client = described_class.new(slug: 'it-ducks', secret_key: '123')

      client.get_organization

      expect(WebMock).to have_requested(
        :get,
        'https://thirdparty.qonto.eu/v2/organizations/it-ducks'
      )
    end

    it 'returns the correct response' do
      client = described_class.new(slug: 'it-ducks', secret_key: '123')

      response = client.get_organization

      expect(response).to be_a(Qonto::Model::Organization)
      expect(response.bank_accounts.first).to be_a(Qonto::Model::BankAccount)
    end
  end

  describe '#list_transactions' do
    before do
      stub_request(:get, %r{/transactions})
        .to_return(read_http_fixture('list_transactions/success.http'))
    end

    it 'builds the request with slug and iban' do
      client = described_class.new(slug: 'it-ducks', secret_key: '123')
      account = Qonto::Model::BankAccount.new(slug: 'my-account', iban: '123456')
      client.list_transactions(bank_account: account)

      expect(WebMock).to have_requested(
        :get,
        'https://thirdparty.qonto.eu/v2/transactions?iban=123456&slug=my-account'
      )
    end

    it 'handles the paginate parameters' do
      client = described_class.new(slug: 'it-ducks', secret_key: '123')
      account = Qonto::Model::BankAccount.new(slug: 'my-account', iban: '123456')
      client.list_transactions(bank_account: account, current_page: 2, per_page: 5)

      expect(WebMock).to have_requested(
        :get,
        'https://thirdparty.qonto.eu/v2/transactions?iban=123456&slug=my-account&current_page=2&per_page=5'
      )
    end

    it 'handles the status parameter' do
      client = described_class.new(slug: 'it-ducks', secret_key: '123')
      account = Qonto::Model::BankAccount.new(slug: 'my-account', iban: '123456')
      client.list_transactions(bank_account: account, status: ['pending', 'completed'])

      expect(WebMock).to have_requested(
        :get,
        'https://thirdparty.qonto.eu/v2/transactions?iban=123456&slug=my-account&status[]=pending&status[]=completed'
      )
    end

    it 'returns the correct response' do
      client = described_class.new(slug: 'it-ducks', secret_key: '123')

      account = Qonto::Model::BankAccount.new(slug: 'my-account', iban: '123456')
      response = client.list_transactions(bank_account: account)

      expect(response.first).to be_a(Qonto::Model::Transaction)
    end
  end
end
