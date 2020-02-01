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

    def ticker_details(symbol)
      get("/v1/meta/symbols/#{symbol}/company", {}, @api_key)
    end

    def ticker_news(symbol, query)
      get("/v1/meta/symbols/#{symbol}/news", query, @api_key)
    end

    def markets
      get('/v2/reference/markets', {}, @api_key)
    end

    def locales
      get('/v2/reference/locales', {}, @api_key)
    end

    def stock_splits(symbol)
      get("/v2/reference/splits/#{symbol}", {}, @api_key)
    end

    def stock_dividends(symbol)
      get("/v2/reference/dividends/#{symbol}", {}, @api_key)
    end

    def stock_financials(symbol, query)
      get("/v2/reference/financials/#{symbol}", query, @api_key)
    end

    def market_status
      get('/v1/marketstatus/now', {}, @api_key)
    end

    def market_holidays
      get('/v1/marketstatus/upcoming', {}, @api_key)
    end
  end
end
