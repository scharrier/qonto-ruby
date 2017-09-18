module Qonto
  module Model
    class Organization  < Base
      attr_accessor :slug
      attr_accessor :bank_accounts
    end
  end
end
