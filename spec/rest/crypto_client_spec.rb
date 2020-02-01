RSpec.describe PolygonClient::CryptoClient do
  it "rest client raises error if api key is not defined" do
    expect{ PolygonClient::CryptoClient.new }.to raise_error(PolygonClient::PolygonError)
  end
end