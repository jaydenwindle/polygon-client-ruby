# frozen_string_literal: true

module PolygonClient
  # Polygon.io Forex Websocket API client.
  # @param [String] api_key your polygon.io API key
  # @see https://polygon.io/sockets
  class ForexWebsocketClient
    include EventEmitter

    def initialize(api_key = nil)
      if api_key.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key'
      end

      @api_key = api_key
    end

    def connect
      @ws = WebSocket::Client::Simple.connect "#{POLYGON_WS_URL}/forex"
      @ws.on :open do
        auth = { action: 'auth', params: @api_key }
        @ws.send auth
      end

      @ws.on :message do |msg|
        emit :message, msg.data
      end
    end

    def subscribe(tickers)
      tickers_string = tickers.join(',')
      action = { action: 'subscribe', params: tickers_string }
      @ws.send action
    end

    def unsubscribe(tickers)
      tickers_string = tickers.join(',')
      action = { action: 'unsubscribe', params: tickers_string }
      @ws.send action
    end
  end
end
