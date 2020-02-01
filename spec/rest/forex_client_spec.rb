RSpec.describe PolygonClient::ForexClient do
  before do
    @client = PolygonClient::ForexClient.new(API_KEY)
  end

  it 'rest client raises error if api key is not defined' do
    expect { PolygonClient::ForexClient.new }.to raise_error(PolygonClient::PolygonError)
  end

  it 'requests previous close correctly' do
    ticker = "AAPL"
    query = {
      unadjusted: true
    }
    stub = api_stub("/v2/aggs/ticker/#{ticker}/prev", query)
    @client.previous_close(ticker, query)
    expect(stub).to have_been_requested
  end

  it 'requests previous close correctly' do
    ticker = 'C:EURUSD'
    query = { unadjusted: false }
    stub = api_stub("/v2/aggs/ticker/#{ticker}/prev", query)
    @client.previous_close(ticker, query)
    expect(stub).to have_been_requested
  end

  it 'requests aggregates correctly' do
    ticker = 'C:EURUSD'
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
    market = 'FX'
    date = '2019-02-01'
    query = { unadjusted: false }

    stub = api_stub(
      "/v2/aggs/grouped/locale/#{locale}/market/#{market}/#{date}",
      query
    )

    @client.grouped_daily(locale, market, date, query)
    expect(stub).to have_been_requested
  end

  it 'requests historic forex ticks correctly' do
    from = 'AUD'
    to = 'USD'
    date = '2018-2-2'
    query = { offset: 1, limit: 100 }
    stub = api_stub("/v1/historic/forex/#{from}/#{to}/#{date}", query)
    @client.historic_forex_ticks(from, to, date, query)
    expect(stub).to have_been_requested
  end

  it 'requests real time currency conversion correctly' do
    from = 'AUD'
    to = 'USD'
    query = { amount: 100, precision: 2 }
    stub = api_stub("/v1/conversion/#{from}/#{to}", query)
    @client.real_time_currency_conversion(from, to, query)
    expect(stub).to have_been_requested
  end

  it 'requests last quote for currency pair correctly' do
    from = 'AUD'
    to = 'USD'
    stub = api_stub("/v1/last_quote/currencies/#{from}/#{to}")
    @client.last_quote_for_currency_pair(from, to)
    expect(stub).to have_been_requested
  end

  it 'requests snapshot - all tickers correctly' do
    stub = api_stub('/v2/snapshot/locale/global/markets/forex/tickers')
    @client.snapshot_all_tickers
    expect(stub).to have_been_requested
  end

  it 'requests snapshot - gainers losers correctly' do
    direction = 'gainers'
    stub = api_stub("/v2/snapshot/locale/global/markets/forex/#{direction}")
    @client.snapshot_gainers_losers
    expect(stub).to have_been_requested

    direction = 'losers'
    stub = api_stub("/v2/snapshot/locale/global/markets/forex/#{direction}")
    @client.snapshot_gainers_losers(direction)
    expect(stub).to have_been_requested
  end

end
