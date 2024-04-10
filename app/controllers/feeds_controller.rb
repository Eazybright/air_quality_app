require 'waqi'

class FeedsController < ApplicationController


    def initialize
        @waqi_client = Waqi::Client::new(api_key: 'f88cca5764b98182b7013d4adb38230912f92cdd')
    end
  def index
    # @feeds = @waqi_client.get_city_feed('beijing')
    # @is_waqi = $LOADED_FEATURES # loaded?('waqi-ruby')
  end

  def loaded?(name)
    r = Regexp.new("#{name}.rb$")
    $LOADED_FEATURES.select{|t| t.match(r) }.any?
  end
end
