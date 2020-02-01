# frozen_string_literal: true

module PolygonClient
  # Polygon.io Crypto REST API client.
  # @param [String] api_key your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class CryptoClient
    def initialize(api_key = nil, stocks_client = nil)
      if api_key.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key to ReferenceClient'
      end

      @stocks_client = stocks_client

      if @stocks_client.nil?
        @stocks_client = PolygonClient::StocksClient.new(api_key)
      end

      @api_key = api_key
    end

    def previous_close(ticker, query)
      @stocks_client.previous_close(ticker, query)
    end

    def aggregates(ticker, multiplier, timespan, from, to, query)
      @stocks_client.aggregates(ticker, multiplier, timespan, from, to, query)
    end

    def grouped_daily(locale, market, date, query)
      @stocks_client.grouped_daily(locale, market, date, query)
    end

    def crypto_exchanges
      get('/v1/meta/crypto-exchanges', {}, @api_key)
    end

    def last_trade_for_crypto_pair(from, to)
      get("/v1/last/crypto/#{from}/#{to}", {}, @api_key)
    end

    def daily_open_close(from, to, date)
      get("/v1/open-close/crypto/#{from}/#{to}/#{date}", {}, @api_key)
    end

    def historic_crypto_trades(from, to, date, query)
      get("/v1/historic/crypto/#{from}/#{to}/#{date}", query, @api_key)
    end

    def snapshot_all_tickers
      get('/v2/snapshot/locale/global/markets/crypto/tickers', {}, @api_key)
    end

    def snapshot_single_ticker(ticker)
      get(
        "/v2/snapshot/locale/global/markets/crypto/tickers/#{ticker}",
        {},
        @api_key
      )
    end

    def snapshot_single_ticker_full_book(ticker)
      get(
        "/v2/snapshot/locale/global/markets/crypto/tickers/#{ticker}/book",
        {},
        @api_key
      )
    end

    def snapshot_gainers_losers(direction = 'gainers')
      get(
        "/v2/snapshot/locale/global/markets/crypto/#{direction}",
        {},
        @api_key
      )
    end
  end
end
