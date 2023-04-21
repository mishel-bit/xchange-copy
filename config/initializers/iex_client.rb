require 'iex-ruby-client'

IEX_CLIENT = IEX::Api::Client.new(
    publishable_token: Rails.application.credentials.dig(:iex, :publishable_token),
    secret_token: Rails.application.credentials.dig(:iex, :secret_token),
    endpoint: 'https://cloud.iexapis.com/v1'
)    