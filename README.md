# Qonto API Ruby Client

The Qonto API Ruby client provides convenient access to the Qonto API from applications written in Ruby language.
It is currently up to date with the `v1` version. Qonto API documentation is avaible at https://api-doc.qonto.eu.

This project is not affiliated with the Qonto company in any way.

## Installation

Add this line to your application's Gemfile:

    gem 'qonto-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qonto-api

## Requirements

* Ruby 2.1+.

## Usage

The library needs to be configured with your account's secret key and organization
slug which are available in your organization dashboard on http://qonto.eu.

    require 'qonto'

    # Initialize your client
    client = Qonto::Client.new(slug: 'your-organization-slug', secret_key: 'your-secret-key')

You can retrieve your organization bank accounts by calling `get_organization`:

    # Retrieve your organization object
    organization = client.get_organization
    bank_account = organization.bank_accounts.first

    # Balance is available for each bank account
    puts "Balance: #{bank_account.balance} €"

You can list transactions for a given bank account by calling `list_transactions`:

    # Paginate through the transactions
    transactions = client.list_transactions(
      bank_account: bank_account,
      per_page: 10,
      current_page: 2
    )

    transactions.each do |transaction|
      puts " #{transaction.side}: #{transaction.amount} #{transaction.currency} - #{transaction.label}"
    end

If a request returns an error, the client raises a `Qonto::Error`. This can be simply
handled by a `begin/rescue` block:

    begin
      organization = client.get_organization
      puts "Balance: #{organization.bank_accounts.first.balance} €"
    rescue Qonto::Error => e
      puts "Oops: #{e.to_s}"
    end

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.
