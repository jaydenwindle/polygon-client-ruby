module PolygonClient
  class WebsocketClient
    @@wsUrl = "https://api.polygon.io"

    def initialize(api_key = nil)
        if api_key.nil?
          raise PolygonClient::PolygonError.new "Must supply a valid Polygon.io API key"
        end

        @api_key = api_key
    end
  end
end