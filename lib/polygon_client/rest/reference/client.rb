# frozen_string_literal: true

require 'polygon_client/rest/transport'

module PolygonClient
  # Polygon.io Reference REST API client.
  # @param [String] api_key your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class ReferenceClient
    def initialize(api_key = nil)
      if api_key.nil?
        raise PolygonClient::PolygonError,
              'Must supply a valid Polygon.io API key to ReferenceClient'
      end

      @api_key = api_key
    end

    def tickers(query)
      get('/v2/reference/tickers', query, @api_key)
    end

    def ticker_types
      get('/v2/reference/types', {}, @api_key)
    end

    def ticker_details(ticker)
      get("/v1/meta/symbols/#{ticker}/company", {}, @api_key)
    end

    def ticker_news(ticker, query)
      get("/v1/meta/symbols/#{ticker}/news", query, @api_key)
    end

    def markets
      get('/v2/reference/markets', {}, @api_key)
    end

    def locales
      get('/v2/reference/locales', {}, @api_key)
    end

    def stock_splits(ticker)
      get("/v2/reference/splits/#{ticker}", {}, @api_key)
    end

    def stock_dividends(ticker)
      get("/v2/reference/dividends/#{ticker}", {}, @api_key)
    end

    def stock_financials(ticker, query)
      get("/v2/reference/financials/#{ticker}", query, @api_key)
    end

    def market_status
      get('/v1/marketstatus/now', {}, @api_key)
    end

    def market_holidays
      get('/v1/marketstatus/upcoming', {}, @api_key)
    end
  end
end
