require "polygon_client/version"
require "polygon_client/rest/client"
require "polygon_client/websockets/client"

module PolygonClient
  class PolygonError < StandardError; end

  class Client
    def initialize(api_key = nil)
        if api_key.nil?
          raise PolygonClient::PolygonError.new "Must supply a valid Polygon.io API key"
        end

        @restClient = PolygonClient::RestClient.new(api_key)
        @wsClient = PolygonClient::WebsocketClient.new(api_key)
    end
  end
end
