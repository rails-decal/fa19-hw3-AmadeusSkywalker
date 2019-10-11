require_relative '../services/weather_service'

class MainController < ApplicationController

  def index
    # Uncomment and pass a parameter to the get function
    # @name = params[:name]
    # @w = WeatherService.get(params[:city])
    #if @w
    #  @temperature = (9.0/5) * (@w[:temperature] - 273) + 32
    @name = params[:city]
    if not @name.nil?
      if not City.all.key?(@name.to_sym)
        city = City.new(
          name: @name
        )
        @w = city.weather
        city.save
      end
    else
      @w = nil;
    end
  end 
end