# frozen_string_literal: true

RSpec.describe PolygonClient::CryptoClient do
  before do
    @client = PolygonClient::CryptoClient.new(API_KEY)
  end

  it 'rest client raises error if api key is not defined' do
    expect { PolygonClient::CryptoClient.new }.to(
      raise_error(PolygonClient::PolygonError)
    )
  end

  it 'requests previous close correctly' do
    ticker = 'X:BTCUSD'
    query = { unadjusted: false }
    stub = api_stub("/v2/aggs/ticker/#{ticker}/prev", query)
    @client.previous_close(ticker, query)
    expect(stub).to have_been_requested
  end

  it 'requests aggregates correctly' do
    ticker = 'X:BTCUSD'
    multiplier = 1
    timespan = 'day'
    from = '2019-01-01'
    to = '2019-02-01'
    query = { unadjusted: false }

    stub = api_stub(
      "/v2/aggs/ticker/#{ticker}" \
      "/range/#{multiplier}/#{timespan}/#{from}/#{to}",
      query
    )

    @client.aggregates(ticker, multiplier, timespan, from, to, query)
    expect(stub).to have_been_requested
  end

  it 'requests grouped daily correctly' do
    locale = 'US'
    market = 'CRYPTO'
    date = '2019-02-01'
    query = { unadjusted: false }

    stub = api_stub(
      "/v2/aggs/grouped/locale/#{locale}/market/#{market}/#{date}",
      query
    )

    @client.grouped_daily(locale, market, date, query)
    expect(stub).to have_been_requested
  end

  it 'requests crypto exchanges correctly' do
    stub = api_stub('/v1/meta/crypto-exchanges')
    @client.crypto_exchanges
    expect(stub).to have_been_requested
  end

  it 'requests last trade for crypto pair correctly' do
    from = 'BTC'
    to = 'USD'
    stub = api_stub("/v1/last/crypto/#{from}/#{to}")
    @client.last_trade_for_crypto_pair(from, to)
    expect(stub).to have_been_requested
  end

  it 'requests daily open close correctly' do
    from = 'BTC'
    to = 'USD'
    date = '2018-5-9'
    stub = api_stub("/v1/open-close/crypto/#{from}/#{to}/#{date}")
    @client.daily_open_close(from, to, date)
    expect(stub).to have_been_requested
  end

  it 'requests historic crypto trades correctly' do
    from = 'BTC'
    to = 'USD'
    date = '2018-5-9'
    query = { offset: 1, limit: 10 }
    stub = api_stub("/v1/historic/crypto/#{from}/#{to}/#{date}", query)
    @client.historic_crypto_trades(from, to, date, query)
    expect(stub).to have_been_requested
  end

  it 'requests snapshot - all tickers correctly' do
    stub = api_stub('/v2/snapshot/locale/global/markets/crypto/tickers')
    @client.snapshot_all_tickers
    expect(stub).to have_been_requested
  end

  it 'requests snapshot - single ticker correctly' do
    ticker = 'X:BTCUSD'
    stub = api_stub(
      "/v2/snapshot/locale/global/markets/crypto/tickers/#{ticker}"
    )
    @client.snapshot_single_ticker(ticker)
    expect(stub).to have_been_requested
  end

  it 'requests snapshot - single ticker correctly' do
    ticker = 'X:BTCUSD'
    stub = api_stub(
      "/v2/snapshot/locale/global/markets/crypto/tickers/#{ticker}/book"
    )
    @client.snapshot_single_ticker_full_book(ticker)
    expect(stub).to have_been_requested
  end

  it 'requests snapshot - gainers losers correctly' do
    direction = 'gainers'
    stub = api_stub("/v2/snapshot/locale/global/markets/crypto/#{direction}")
    @client.snapshot_gainers_losers
    expect(stub).to have_been_requested

    direction = 'losers'
    stub = api_stub("/v2/snapshot/locale/global/markets/crypto/#{direction}")
    @client.snapshot_gainers_losers(direction)
    expect(stub).to have_been_requested
  end
end
