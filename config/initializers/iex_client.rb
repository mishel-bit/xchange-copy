require 'iex-ruby-client'

IEX_CLIENT = IEX::Api::Client.new(
    publishable_token: 'pk_06f0670b09884fe5aa66d394e4263f00',
    secret_token: 'sk_f528b0c334f24d498705a205d72a7ec4',
    endpoint: 'https://cloud.iexapis.com/v1'
)    