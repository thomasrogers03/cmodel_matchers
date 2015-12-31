module CassandraModel
  module Matchers
    class TruthTableMatcher < Struct.new(:keys)
      def description
        'nope'
      end

      def matches?(object)
        @object = object
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
        "Expected #{@object} to be inquirable by #{keys * ', '}"
      end

      def failure_message_when_negated
        "Expected #{@object} not to be inquirable by #{keys * ', '}"
      end
    end

    class UniquenessMatcher < Struct.new(:keys)
      def description
        'nope'
      end

      def matches?(object)
        object.superclass == Record &&
            (object.partition_key == keys || object.clustering_columns == keys)
      end

      def failure_message
        "Expected #{@object} to be have clustering columns #{keys * ', '}"
      end

      def failure_message_when_negated
        "Expected #{@object} not to have clustering columns #{keys * ', '}"
      end
    end

    module TableDefiningMatchers
      def be_inquirable_by(*keys)
        TruthTableMatcher.new(keys)
      end

      def be_unique_by(*keys)
        UniquenessMatcher.new(keys)
      end
    end
  end
end
