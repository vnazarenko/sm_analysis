class Api::TickersController < ApplicationController
  # This action retrieves a list of items based on specified filter criteria.
  # It supports filtering by sector and gross margin.
  #
  # @overload index(filter: params)
  #   @param filter [Hash] The filter criteria for narrowing down the search results.
  #   @option filter [Array<String>] :sector (nil) List of sectors to include in the results.
  #     Valid sectors are "Technology", "Healthcare", "Finance", "Consumer Cyclical",
  #     "Industrials", "Basic Materials", "Real Estate", "Energy", "Consumer Defensive",
  #     "Utilities", "Communication Services", "Financial Services", "Industrial Goods",
  #     "Technology Services", "Consumer Products", "Conglomerates", "Other", "Unclassified".
  #   @option filter [Hash] :grosMargin ({min: 0, max: nil}) Gross margin range for filtering.
  #     - :min (Integer) specifies the minimum gross margin percentage (inclusive).
  #     - :max (Integer, nil) specifies the maximum gross margin percentage (inclusive).
  #       If nil, there is no upper limit on the gross margin.
  #   @option filter [String] :ticker (nil) Ticker symbol to include in the results.
  #   @option filter [String] :company_name (nil) Company name to include in the results.
  #   @option filter [Hash] :pe_ttm ({min: 0, max: nil}) PE TTM range for filtering.
  #     - :min (Integer) specifies the minimum PE TTM (inclusive).
  #     - :max (Integer, nil) specifies the maximum PE TTM (inclusive).
  #       If nil, there is no upper limit on the PE TTM.
  #   @option filter [Hash] :acquirer_multiple ({min: 0, max: nil}) Acquirer multiple range for filtering.
  #     - :min (Integer) specifies the minimum acquirer multiple (inclusive).
  #     - :max (Integer, nil) specifies the maximum acquirer multiple (inclusive).
  #       If nil, there is no upper limit on the acquirer multiple.
  #   @option filter [Hash] :earning_yield_p ({min: 0, max: nil}) Earning yield range for filtering.
  #     - :min (Integer) specifies the minimum earning yield percentage (inclusive).
  #     - :max (Integer, nil) specifies the maximum earning yield percentage (inclusive).
  #       If nil, there is no upper limit on the earning yield.
  #   @param sort [Hash] The sorting criteria for the search results.
  #   @option sortBy [String] :field ("ticker") The field to sort the results by.
  #   @option sortOrder [String] :direction ("asc", "desc") The direction to sort the results by.
  #   @param pagination [Hash] The pagination criteria for the search results.
  #   @option page [Integer] :number (1) The page number to retrieve.
  #   @option perPage [Integer] :size (25) The number of items per page.
  #
  # @return [JSON] A list of items that match the filter criteria.
  def index
    @tickers = Ticker.all
    eq_filter_by(:sector, :sector)
    range_filter_by(:gross_margin_p, :gross_margin_p)
    eq_filter_by(:ticker, :ticker)
    eq_filter_by(:company_name, :company_name)
    range_filter_by(:pe_ttm, :pe_ttm)
    range_filter_by(:acquirer_multiple, :acquirer_multiple)
    range_filter_by(:earning_yield_p, :earning_yield_p)


    count = @tickers.count
    page = params.dig(:pagination, :page).to_i
    per_page = params.dig(:pagination, :perPage) || 25
    @tickers = @tickers.order(params[:sort][:sortBy] => params[:sort][:sortOrder]) if params[:sort].present?
    @tickers = @tickers.page(page).per(per_page)

    render json: {tickers: @tickers, total_count: count, page: page, per_page: per_page}
  end

  def range_filter_by(field, db_field)
    if params.dig(:filter, field).present?
      min = params[:filter][field][:min]
      max = params[:filter][field][:max]

      @tickers = @tickers.where("#{db_field} >= ?", min) if min.present?
      @tickers = @tickers.where("#{db_field} <= ?", max) if max.present?
    end
  end

  def eq_filter_by(field, db_field)
    @tickers = @tickers.where(db_field => params.dig(:filter, field)) if params.dig(:filter, field).present?
  end
end
