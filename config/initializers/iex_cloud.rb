require 'faraday'
require "ostruct"

response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_06f0670b09884fe5aa66d394e4263f00')
IEX_CLOUD = JSON.parse(response.body, object_class: OpenStruct)