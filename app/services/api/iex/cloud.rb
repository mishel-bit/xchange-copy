module Api
    module Iex
        class Cloud
            TOKEN = Rails.application.credentials.dig(:iex, :publishable_token)
            BASE_URL = "https://api.iex.cloud/v1/data/CORE/REF_DATA"
            
            def self.call
                result = RestClient::Request.execute(
                    method: 'get',
                    url: "#{BASE_URL}?token=#{TOKEN}",
                    headers: {'Content-Type' => 'application/json'}
                )
                JSON.parse(result.body, object_class: OpenStruct)
                # IEX_CLOUD
            end
        end
    end
end