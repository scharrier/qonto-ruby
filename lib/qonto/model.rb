module Qonto
  module Model
    class Base
      def initialize(attributes = {})
        attributes.each do |key, value|
          m = "#{key}=".to_sym
          send(m, value) if respond_to?(m)
        end
      end
    end
  end
end

require_relative 'model/bank_account'
require_relative 'model/organization'
require_relative 'model/transaction'
