require 'rspec'

module CassandraModel
  module Matchers
    describe TableDefiningMatchers do
      include TableDefiningMatchers

      describe 'a simple table' do
        class MockRecord < Record
          extend DataModelling

          model_data do |inquirer, data_set|
            inquirer.knows_about(:key)
            data_set.knows_about(:value)
          end
        end

        subject { MockRecord }

        it { is_expected.to be_inquirable_by(:key) }
        it { is_expected.not_to be_inquirable_by(:value) }
      end

      describe 'a table defining composite queries' do
        class OtherMockRecord < Record
          extend DataModelling

          self.table_name = :records_two

          model_data do |inquirer, data_set|
            inquirer.knows_about(:key)
            inquirer.knows_about(:other_key)
          end
        end

        subject { OtherMockRecord }

        it { is_expected.to be_inquirable_by(:key) }
        it { is_expected.to be_inquirable_by(:other_key) }
        it { is_expected.to be_inquirable_by(:key, :other_key) }
      end

      describe 'a table defining composite queries sharing partition keys' do
        class SharedPKRecord < Record
          extend DataModelling

          self.table_name = :spk_records

          model_data do |inquirer, data_set|
            inquirer.knows_about(:key)
            inquirer.knows_about(:key, :other_key)
          end
        end

        subject { SharedPKRecord }

        it { is_expected.to be_inquirable_by(:key) }
        it { is_expected.to be_inquirable_by(:key, :other_key) }
        it { is_expected.not_to be_inquirable_by(:other_key) }
      end

    end
  end
end
