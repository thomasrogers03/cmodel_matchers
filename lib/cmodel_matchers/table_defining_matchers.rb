module CassandraModel
  module Matchers
    class TruthTableMatcher < Struct.new(:keys)
      def description
        'nope'
      end

      def matches?(object)
        object.superclass == Record &&
            keys.all? { |column| object.partition_key.include?(column) } &&
            (
            object.partition_key == keys ||
                object.composite_defaults.empty? || begin

              missing_keys = Set.new(object.internal_partition_key - keys.map { |column| object.composite_pk_map[column] })
              object.composite_defaults.find { |row| (missing_keys ^ row.keys).empty? }
            end
            )
      end

      def failure_message
        'nope'
      end

      def failure_message_when_negated
        'other nope'
      end
    end

    module TableDefiningMatchers
      def be_inquirable_by(*keys)
        TruthTableMatcher.new(keys)
      end
    end
  end
end
