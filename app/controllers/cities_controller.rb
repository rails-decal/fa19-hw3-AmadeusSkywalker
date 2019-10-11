class CitiesController < ApplicationController

    def view
        @c = params[:city]
        @w = WeatherService.get(@c)
        if @w 
            @temperature = (9/5) * (@w[:temperature] - 273) + 32
        end
    end

    def new
    end

    def create
        if not City.all.key?(params[:city].to_sym)
            @name = params[:city]
            @landmark = params[:landmark] 
            @population = params[:population]
            @pop = Integer(@population) rescue nil
            @city = City.new(
                name: @name,
                landmark: @landmark,
                population: @pop
            )
            @city.save
        end
        redirect_to controller: 'cities', action: 'view', city: params[:city]
    end

    def update
        if not params[:name].nil?
            @name = params[:name]
            @population = params[:population]
            @landmark = params[:landmark]
            @pop = Integer(@population) rescue nil
            if City.all.key?(@name.to_sym)
               @city = City.all[@name.to_sym]
               @city.update(population:@pop, landmark:@landmark)
               @city.save
            end
            redirect_to controller: 'cities', action: 'view', city: @name
        end
    end
end