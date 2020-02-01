# frozen_string_literal: true

module PolygonClient
  # Polygon.io Crypto REST API client.
  # @param [String] api_key your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class CryptoClient
    def initialize(api_key = nil, stocks_client = nil)
      if api_key.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key to ReferenceClient'
      end

      @stocks_client = stocks_client

      if @stocks_client.nil?
        @stocks_client = PolygonClient::StocksClient.new(api_key)
      end

      @api_key = api_key
    end
  end
end
