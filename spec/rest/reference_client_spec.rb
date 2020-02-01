# frozen_string_literal: true

RSpec.describe PolygonClient::ReferenceClient do
  before do
    @client = PolygonClient::ReferenceClient.new(API_KEY)
  end

  it 'rest client raises error if api key is not defined' do
    expect { PolygonClient::ReferenceClient.new }.to(
      raise_error(PolygonClient::PolygonError)
    )
  end

  it 'requests tickers correctly' do
    query = {
      sort: 'type',
      type: 'cs'
    }
    stub = api_stub('/v2/reference/tickers', query)
    @client.tickers(query)
    expect(stub).to have_been_requested
  end

  it 'requests ticker types correctly' do
    stub = api_stub('/v2/reference/types')
    @client.ticker_types
    expect(stub).to have_been_requested
  end

  it 'requests ticker details correctly' do
    ticker = 'AAPL'
    stub = api_stub("/v1/meta/symbols/#{ticker}/company")
    @client.ticker_details(ticker)
    expect(stub).to have_been_requested
  end

  it 'requests ticker news correctly' do
    ticker = 'AAPL'
    query = { perPage: 10, page: 2 }
    stub = api_stub("/v1/meta/symbols/#{ticker}/news", query)
    @client.ticker_news(ticker, query)
    expect(stub).to have_been_requested
  end

  it 'requests markets correctly' do
    stub = api_stub('/v2/reference/markets')
    @client.markets
    expect(stub).to have_been_requested
  end

  it 'requests locales correctly' do
    stub = api_stub('/v2/reference/locales')
    @client.locales
    expect(stub).to have_been_requested
  end

  it 'requests stock splits correctly' do
    ticker = 'APPL'
    stub = api_stub("/v2/reference/splits/#{ticker}")
    @client.stock_splits(ticker)
    expect(stub).to have_been_requested
  end

  it 'requests stock dividends correctly' do
    ticker = 'APPL'
    stub = api_stub("/v2/reference/dividends/#{ticker}")
    @client.stock_dividends(ticker)
    expect(stub).to have_been_requested
  end

  it 'requests stock financials correctly' do
    ticker = 'APPL'
    query = { limit: 5, type: 'YA', sort: 'reportPeriod' }
    stub = api_stub("/v2/reference/financials/#{ticker}", query)
    @client.stock_financials(ticker, query)
    expect(stub).to have_been_requested
  end

  it 'requests market status correctly' do
    stub = api_stub('/v1/marketstatus/now')
    @client.market_status
    expect(stub).to have_been_requested
  end

  it 'requests market holidays correctly' do
    stub = api_stub('/v1/marketstatus/upcoming')
    @client.market_holidays
    expect(stub).to have_been_requested
  end
end
