module ApplicationHelper
    def determineLabel(name)
        case name
        when "co"
            { "label" => "Carbon monoxide", "unit" => "ppm" }
        when "no2"
            { "label" => "Nitrogen dioxide", "unit" => "ppb" }
        when "pm10"
            { "label" => "PM10", "unit" => "µg/m³" }
        when "pm25"
            { "label" => "PM25", "unit" => "µg/m³" }
        when "o3"
            { "label" => "Ozone", "unit" => "ppb" }
        when "w"
            { "label" => "Wind Speed", "unit" => "m/s" }
        when "t"
            { "label" => "Temperature", "unit" => "°C" }
        when "p"
            { "label" => "Air pressure", "unit" => "mb" }
        when "so2"
            { "label" => "Sulfur dioxide", "unit" => "ppb" }
        when "h"
            { "label" => "Humidity", "unit" => "%"} 
        when "dew"
            { "label" => "Dew", "unit" => "°C"}
        end
    end
end
