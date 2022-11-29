class PlanetsController < ApplicationController

    def index
        planets = Planet.all
        render json: planets, except: [:created_at, :updated_at], status: :ok
    end
end
