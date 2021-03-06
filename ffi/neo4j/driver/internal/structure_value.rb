# frozen_string_literal: true

module Neo4j
  module Driver
    module Internal
      module StructureValue
        def match(cd)
          self if code == cd
        end

        def to_ruby(value)
          to_ruby_value(*Array.new(size, &method(:ruby_value).curry.call(value)))
        end

        def to_neo(value, object)
          Bolt::Value.format_as_structure(value, code, size)
          Array(to_neo_values(object)).each_with_index do |elem, index|
            Neo4j::Driver::Value.to_neo(Bolt::Structure.value(value, index), elem)
          end
        end

        private

        def ruby_value(value, index)
          Neo4j::Driver::Value.to_ruby(Bolt::Structure.value(value, index))
        end

        def code
          code_sym.to_s.getbyte(0)
        end

        def size
          method(:to_ruby_value).arity
        end
      end
    end
  end
end
