RSpec.describe PolygonClient::StocksClient do
  it "rest client raises error if api key is not defined" do
    expect{ PolygonClient::StocksClient.new }.to raise_error(PolygonClient::PolygonError)
  end
end
