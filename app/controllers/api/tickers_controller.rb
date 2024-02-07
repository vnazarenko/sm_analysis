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
    @tickers = @tickers.where(sector: params[:filter][:sector]) if params&.dig(:filter, :sector).present?
    if params.dig(:filter, :grosMargin).present?
      min_margin = params[:filter][:grosMargin][:min]
      max_margin = params[:filter][:grosMargin][:max]

      @items = @items.where('gross_margin >= ?', min_margin) if min_margin.present?
      @items = @items.where('gross_margin <= ?', max_margin) if max_margin.present?
    end
    count = @tickers.count
    page = params.dig(:pagination, :page).to_i
    per_page = params.dig(:pagination, :perPage) || 25
    @tickers = @tickers.order(params[:sort][:sortBy] => params[:sort][:sortOrder]) if params[:sort].present?
    @tickers = @tickers.page(page).per(per_page)

    render json: {tickers: @tickers, total_count: count, page: page, per_page: per_page}
  end
end
