# frozen_string_literal: true

module Neo4j
  module Driver
    module Ext
      module InternalRecord
        def values
          java_send(:values).map(&:as_ruby_object)
        end

        define_method(:[]) do |key|
          java_method(:get, [java.lang.String]).call(key.to_s).as_ruby_object
        end

        def first
          java_method(:get, [Java::int]).call(0).as_ruby_object
        end
      end
    end
  end
end
