# frozen_string_literal: true

RSpec.describe PolygonClient::StocksClient do
  before do
    @client = PolygonClient::StocksClient.new(API_KEY)
  end

  it 'rest client raises error if api key is not defined' do
    expect { PolygonClient::StocksClient.new }.to(
      raise_error(PolygonClient::PolygonError)
    )
  end

  it 'requests exchanges correctly' do
    stub = api_stub('/v1/meta/exchanges')
    @client.exchanges
    expect(stub).to have_been_requested
  end

  it 'requests historic trades correctly' do
    ticker = 'AAPL'
    date = '2018-02-02'
    query = { reverse: true, limit: 10, timestamp: 1_580_579_296 }
    stub = api_stub("/v2/ticks/stocks/trades/#{ticker}/#{date}", query)
    @client.historic_trades(ticker, date, query)
    expect(stub).to have_been_requested
  end

  it 'requests historic quotes correctly' do
    ticker = 'AAPL'
    date = '2018-02-02'
    query = { reverse: true, limit: 10, timestamp: 1_580_579_296 }
    stub = api_stub("/v2/ticks/stocks/nbbo/#{ticker}/#{date}", query)
    @client.historic_quotes(ticker, date, query)
    expect(stub).to have_been_requested
  end

  it 'requests last trade for symbol correctly' do
    ticker = 'AAPL'
    stub = api_stub("/v1/last/stocks/#{ticker}")
    @client.last_trade_for_symbol(ticker)
    expect(stub).to have_been_requested
  end

  it 'requests last quote for symbol correctly' do
    ticker = 'AAPL'
    stub = api_stub("/v1/last_quote/stocks/#{ticker}")
    @client.last_quote_for_symbol(ticker)
    expect(stub).to have_been_requested
  end

  it 'requests daily open close correctly' do
    ticker = 'AAPL'
    date = '2018-02-02'
    stub = api_stub("/v1/open-close/#{ticker}/#{date}")
    @client.daily_open_close(ticker, date)
    expect(stub).to have_been_requested
  end

  it 'requests condition mappings correctly' do
    ticktype = 'trades'
    stub = api_stub("/v1/meta/conditions/#{ticktype}")
    @client.condition_mappings
    expect(stub).to have_been_requested

    ticktype = 'quotes'
    stub = api_stub("/v1/meta/conditions/#{ticktype}")
    @client.condition_mappings(ticktype)
    expect(stub).to have_been_requested
  end

  it 'requests snapshot - all tickers correctly' do
    stub = api_stub('/v2/snapshot/locale/us/markets/stocks/tickers')
    @client.snapshot_all_tickers
    expect(stub).to have_been_requested
  end

  it 'requests snapshot - single ticker correctly' do
    ticker = 'AAPL'
    stub = api_stub("/v2/snapshot/locale/us/markets/stocks/tickers/#{ticker}")
    @client.snapshot_single_ticker(ticker)
    expect(stub).to have_been_requested
  end

  it 'requests snapshot - gainers losers correctly' do
    direction = 'gainers'
    stub = api_stub("/v2/snapshot/locale/us/markets/stocks/#{direction}")
    @client.snapshot_gainers_losers
    expect(stub).to have_been_requested

    direction = 'losers'
    stub = api_stub("/v2/snapshot/locale/us/markets/stocks/#{direction}")
    @client.snapshot_gainers_losers(direction)
    expect(stub).to have_been_requested
  end

  it 'requests previous close correctly' do
    ticker = 'AAPL'
    query = { unadjusted: false }
    stub = api_stub("/v2/aggs/ticker/#{ticker}/prev", query)
    @client.previous_close(ticker, query)
    expect(stub).to have_been_requested
  end

  it 'requests aggregates correctly' do
    ticker = 'AAPL'
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
    market = 'STOCKS'
    date = '2019-02-01'
    query = { unadjusted: false }

    stub = api_stub(
      "/v2/aggs/grouped/locale/#{locale}/market/#{market}/#{date}",
      query
    )

    @client.grouped_daily(locale, market, date, query)
    expect(stub).to have_been_requested
  end
end
