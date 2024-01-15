# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# clickhouse:schema:load`. When creating a new database, `rails clickhouse:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ClickhouseActiverecord::Schema.define(version: 2024_01_15_115041) do

  # TABLE: tickers
  # SQL: CREATE TABLE sm_analysis_dev.tickers ( `ticker` LowCardinality(String), `company_name` String, `sector` LowCardinality(String), `industry` LowCardinality(String), `fin_currency` LowCardinality(String), `country` LowCardinality(String), `market_cap` UInt64, `acquirer_multiple` Float32, `earning_yield_p` Float32, `pe_ttm` Float32, `ev` Int64, `ev_calc` Float64, `gross_margin_p` Float32, `net_margin_p` Float32, `roe_p` Float32, `roa_p` Float32, `roc_p` Float32, `pb` Float32, `operating_income` Float64, `ebit` Float64, `net_income` Float64, `total_assets` Float64, `cash` Float64, `total_liabilities` Float64, `shareholders_equity` Float64, `preferred_stock_equity` Float64, `minority_interest` Float64, `total_capitalization` Float64, `total_debt` Float64, `working_capital` Float64 ) ENGINE = MergeTree ORDER BY (industry, sector, ticker) SETTINGS index_granularity = 8192
  create_table "tickers", id: false, options: "MergeTree ORDER BY (industry, sector, ticker) SETTINGS index_granularity = 8192", force: :cascade do |t|
    t.string "ticker", null: false
    t.string "company_name", null: false
    t.string "sector", null: false
    t.string "industry", null: false
    t.string "fin_currency", null: false
    t.string "country", null: false
    t.integer "market_cap", limit: 8, null: false
    t.float "acquirer_multiple", null: false
    t.float "earning_yield_p", null: false
    t.float "pe_ttm", null: false
    t.integer "ev", unsigned: false, limit: 8, null: false
    t.float "ev_calc", null: false
    t.float "gross_margin_p", null: false
    t.float "net_margin_p", null: false
    t.float "roe_p", null: false
    t.float "roa_p", null: false
    t.float "roc_p", null: false
    t.float "pb", null: false
    t.float "operating_income", null: false
    t.float "ebit", null: false
    t.float "net_income", null: false
    t.float "total_assets", null: false
    t.float "cash", null: false
    t.float "total_liabilities", null: false
    t.float "shareholders_equity", null: false
    t.float "preferred_stock_equity", null: false
    t.float "minority_interest", null: false
    t.float "total_capitalization", null: false
    t.float "total_debt", null: false
    t.float "working_capital", null: false
  end

end
