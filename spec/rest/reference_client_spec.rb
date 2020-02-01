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
    symbol = 'AAPL'
    stub = api_stub("/v1/meta/symbols/#{symbol}/company")
    @client.ticker_details(symbol)
    expect(stub).to have_been_requested
  end

  it 'requests ticker news correctly' do
    symbol = 'AAPL'
    query = { perPage: 10, page: 2 }
    stub = api_stub("/v1/meta/symbols/#{symbol}/news", query)
    @client.ticker_news(symbol, query)
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
    symbol = 'APPL'
    stub = api_stub("/v2/reference/splits/#{symbol}")
    @client.stock_splits(symbol)
    expect(stub).to have_been_requested
  end

  it 'requests stock dividends correctly' do
    symbol = 'APPL'
    stub = api_stub("/v2/reference/dividends/#{symbol}")
    @client.stock_dividends(symbol)
    expect(stub).to have_been_requested
  end

  it 'requests stock financials correctly' do
    symbol = 'APPL'
    query = { limit: 5, type: 'YA', sort: 'reportPeriod' }
    stub = api_stub("/v2/reference/financials/#{symbol}", query)
    @client.stock_financials(symbol, query)
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
