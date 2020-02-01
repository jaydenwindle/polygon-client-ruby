RSpec.describe PolygonClient::ForexClient do
  it "rest client raises error if api key is not defined" do
    expect{ PolygonClient::ForexClient.new }.to raise_error(PolygonClient::PolygonError)
  end
end