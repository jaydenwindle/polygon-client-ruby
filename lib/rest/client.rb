require 'net/http'

module PolygonClient
  class RestClient

    @@apiUrl = "https://api.polygon.io"

    def initialize(apiKey = nil)
        if apiKey.nil?
          raise Error "Must supply a valid Polygon.io API key"
        end

        @apiKey = apiKey     
    end
  end
end
