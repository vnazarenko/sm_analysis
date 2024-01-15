class ClickhouseRecord < ActiveRecord::Base
  self.abstract_class = true

  connects_to database: { writing: :clickhouse, reading: :clickhouse }

  class << self
    def optimize
      connection.execute("OPTIMIZE TABLE #{table_name} FINAL")
    end
  end
end
