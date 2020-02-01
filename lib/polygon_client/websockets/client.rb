# frozen_string_literal: true

module PolygonClient
  # Top-level Polygon.io Websocket API client.
  # @param [String] api_key your polygon.io API key
  # @see https://polygon.io/sockets
  class WebsocketClient
    def initialize(api_key = nil)
      if api_key.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key'
      end

      @api_key = api_key

      @stocks = PolygonClient::StocksWebsocketClient.new(api_key)
      @forex = PolygonClient::ForexWebsocketClient.new(api_key)
      @crypto = PolygonClient::CryptoWebsocketClient.new(api_key)
    end

    attr_reader :stocks
    attr_reader :forex
    attr_reader :crypto
  end
end
