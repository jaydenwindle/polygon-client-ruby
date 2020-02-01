# frozen_string_literal: true

require 'httparty'

POLYGON_API_URL = 'https://api.polygon.io'

def get(path, query, api_key)
  auth_query = query.merge(api_key: api_key)
  HTTParty.get("#{POLYGON_API_URL}#{path}", query: auth_query)
end
