class DataImport::Clickhouse
  class << self
    def import_data
      # batch_size = 1000

      # File.open("All_tickers_20240107.csv") do |file|
      #   headers = file.first
      #   file.lazy.each_slice(batch_size) do |lines|
      #     ClickhouseRecord.connection.execute <<-SQL
      #       INSERT INTO tickers VALUES((#{lines.join('),(')}))
      #     SQL
      #
      #     # do something with 2000 csv rows, e.g. bulk insert them into a database
      #   end
      # end

      `clickhouse client -d #{ENV['CH_DATABASE_NAME']} -q "INSERT INTO tickers FORMAT CSVWithNames" < All_tickers_20240107.csv`
    end
  end
end