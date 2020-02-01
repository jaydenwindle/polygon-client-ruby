# frozen_string_literal: true

require 'polygon_client/rest/reference/client'
require 'polygon_client/rest/stocks/client'
require 'polygon_client/rest/forex/client'
require 'polygon_client/rest/crypto/client'

module PolygonClient
  # Top-level Polygon.io REST API client.
  # @param [String] api_key your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class RestClient
    def initialize(api_key = nil)
      if api_key.nil?
        raise PolygonClient::PolygonError,
              'Must supply a valid Polygon.io API key to RestClient'
      end

      @api_key = api_key

      @reference = ReferenceClient.new(api_key)
      @stocks = StocksClient.new(api_key)
      @forex = ForexClient.new(api_key, @stocks)
      @crypto = CryptoClient.new(api_key, @stocks)
    end

    attr_reader :reference
    attr_reader :stocks
    attr_reader :forex
    attr_reader :crypto
  end
end
