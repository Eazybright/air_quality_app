require 'waqi'

class FeedsController < ApplicationController
    before_action :set_client
   
    def index
        @city = request.query_parameters['city']
        if !@city.blank?
            @feeds = @waqi_client.get_city_feed(@city)
        end
    end

    private 
    
    def set_client
        @waqi_client = Waqi::Client::new(api_key: Rails.application.credentials[:air_quality_data_token])
    end
end
