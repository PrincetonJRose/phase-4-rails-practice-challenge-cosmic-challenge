class MissionsController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create
        mission = Mission.create!( mission_params )
        render json: mission.planet, except: [:created_at, :updated_at], status: :created
    end

    private

    def mission_params
        params.require( :mission ).permit( :scientist_id, :planet_id, :name )
    end

    def render_unprocessable_entity_response invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
