RSpec.describe PolygonClient::RestClient do
  it "rest client raises error if api key is not defined" do
    expect{ PolygonClient::RestClient.new }.to raise_error(PolygonClient::PolygonError)
  end
  it "rest client initializes reference client" do
    client = PolygonClient::RestClient.new("api_key")
    expect(client.reference).to be_a(PolygonClient::ReferenceClient)
  end
  it "rest client initializes stocks client" do
    client = PolygonClient::RestClient.new("api_key")
    expect(client.stocks).to be_a(PolygonClient::StocksClient)
  end
  it "rest client initializes forex client" do
    client = PolygonClient::RestClient.new("api_key")
    expect(client.forex).to be_a(PolygonClient::ForexClient)
  end
  it "rest client initializes crypto client" do
    client = PolygonClient::RestClient.new("api_key")
    expect(client.crypto).to be_a(PolygonClient::CryptoClient)
  end
end
