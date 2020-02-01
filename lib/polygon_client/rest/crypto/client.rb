# frozen_string_literal: true

module PolygonClient
  # Polygon.io Crypto REST API client.
  # @param [String] api_key your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class CryptoClient
    def initialize(api_key = nil)
      if api_key.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key to ReferenceClient'
      end

      @api_key = api_key
    end
  end
end