require 'waqi'
require 'ostruct'

class FeedsController < ApplicationController
    before_action :set_client
   
    def index
        @city = request.query_parameters['city']
        if !@city.blank?
            response = @waqi_client.get_city_feed(@city)

            if response["status"] == "ok"
                @response = response["data"]
                @city_info = response["data"]["city"]

                @iaqi = response["data"]["iaqi"].map do |key, value|
                      { "name" => key.to_s, "value" => value["v"] } 
                end

                @forecast = response["data"]["forecast"]["daily"]

                @daily_forecast = format_forecast_data(@forecast)

            elsif response["status"] == "error"
                @isError = true
                @response = response
            end
        end
    end

    private 
    
    def set_client
        @waqi_client = Waqi::Client::new(api_key: Rails.application.credentials[:air_quality_data_token])
    end

    def format_forecast_data(air_quality_data)
        # Extract days from "o3", "pm10", and "pm25" arrays
        o3_days = air_quality_data["o3"].map { |data| data["day"] } || []
        pm10_days = air_quality_data["pm10"].map { |data| data["day"] } || []
        pm25_days = air_quality_data["pm25"].map { |data| data["day"] } || []
      
        # Find intersection of the three arrays
        identical_days = o3_days & pm10_days & pm25_days
        formatted_parameter_data = []
      
          # Extract required values and push into new array
        identical_days.each do |date|
            o3_index = air_quality_data["o3"].find_index { |entry| entry["day"] == date }
            pm10_index = air_quality_data["pm10"].find_index { |entry| entry["day"] == date }
            pm25_index = air_quality_data["pm25"].find_index { |entry| entry["day"] == date }

            formatted_parameter_data << [date, air_quality_data["o3"][o3_index]["avg"], air_quality_data["pm10"][pm10_index]["avg"], air_quality_data["pm25"][pm25_index]["avg"]]
        end
        formatted_parameter_data
    end
end