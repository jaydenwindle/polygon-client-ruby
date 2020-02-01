# frozen_string_literal: true

require 'polygon_client/rest/transport'

module PolygonClient
  # Polygon.io Stocks REST API client.
  # @param [String] api_key your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class StocksClient
    def initialize(api_key = nil)
      if api_key.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key to ReferenceClient'
      end

      @api_key = api_key
    end

    def exchanges
      get('/v1/meta/exchanges', {}, @api_key)
    end

    def historic_trades(ticker, date, query)
      get("/v2/ticks/stocks/trades/#{ticker}/#{date}", query, @api_key)
    end

    def historic_quotes(ticker, date, query)
      get("/v2/ticks/stocks/nbbo/#{ticker}/#{date}", query, @api_key)
    end

    def last_trade_for_symbol(ticker)
      get("/v1/last/stocks/#{ticker}", {}, @api_key)
    end

    def last_quote_for_symbol(ticker)
      get("/v1/last_quote/stocks/#{ticker}", {}, @api_key)
    end

    def daily_open_close(ticker, date)
      get("/v1/open-close/#{ticker}/#{date}", {}, @api_key)
    end

    def condition_mappings(ticktype = 'trades')
      get("/v1/meta/conditions/#{ticktype}", {}, @api_key)
    end

    def snapshot_all_tickers
      get('/v2/snapshot/locale/us/markets/stocks/tickers', {}, @api_key)
    end

    def snapshot_single_ticker(ticker)
      get(
        "/v2/snapshot/locale/us/markets/stocks/tickers/#{ticker}",
        {},
        @api_key
      )
    end

    def snapshot_gainers_losers(direction = 'gainers')
      get(
        "/v2/snapshot/locale/us/markets/stocks/#{direction}",
        {},
        @api_key
      )
    end

    def previous_close(ticker, query)
      get("/v2/aggs/ticker/#{ticker}/prev", query, @api_key)
    end

    def aggregates(ticker, multiplier, timespan, from, to, query)
      get(
        "/v2/aggs/ticker/#{ticker}" \
        "/range/#{multiplier}/#{timespan}/#{from}/#{to}",
        query,
        @api_key
      )
    end

    def grouped_daily(locale, market, date, query)
      get(
        "/v2/aggs/grouped/locale/#{locale}/market/#{market}/#{date}",
        query,
        @api_key
      )
    end
  end
end
