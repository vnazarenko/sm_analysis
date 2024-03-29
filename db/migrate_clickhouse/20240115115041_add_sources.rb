class AddSources < ActiveRecord::Migration[7.0]
  def up
    connection.execute(<<~SQL.squish)
      CREATE TABLE tickers
        (
          ticker LowCardinality(String),
          company_name String,
          sector LowCardinality(String),
          industry LowCardinality(String),
          fin_currency LowCardinality(String),
          country LowCardinality(String),
          market_cap UInt64,
          acquirer_multiple Float32,
          earning_yield_p Float32,
          pe_ttm Float32,
          ev Int64,
          ev_calc Float64,
          gross_margin_p Float32,
          net_margin_p Float32,
          roe_p Float32,
          roa_p Float32,
          roc_p Float32,
          pb Float32,
          operating_income Float64,
          ebit Float64,
          net_income Float64,
          total_assets Float64,
          cash Float64,
          total_liabilities Float64,
          shareholders_equity Float64,
          preferred_stock_equity Float64,
          minority_interest Float64,
          total_capitalization Float64,
          total_debt Float64,
          working_capital Float64,
        ) ENGINE = MergeTree
        ORDER BY (industry, sector, ticker)
    SQL
  end

  def down
    connection.execute(<<~SQL.squish)
      DROP TABLE tickers
    SQL
  end
end
