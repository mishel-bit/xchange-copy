require 'faraday'
require "ostruct"

response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token='+Rails.application.credentials.dig(:iex, :publishable_token))
IEX_CLOUD = JSON.parse(response.body, object_class: OpenStruct)