API_KEY = "api_key"

def api_stub(path, query={})
  return stub_request(:get, "#{POLYGON_API_URL}#{path}").
    with(:query => query.merge({:api_key => API_KEY}))
end

RSpec.describe PolygonClient do
  it "has a version number" do
    expect(PolygonClient::VERSION).not_to be nil
  end

  it "websocket client raises error if api key is not defined" do
    expect{ PolygonClient::WebsocketClient.new }.to raise_error(PolygonClient::PolygonError)
  end

  it "polygon client raises error if api key is not defined" do
    expect{ PolygonClient::Client.new }.to raise_error(PolygonClient::PolygonError)
  end

end
