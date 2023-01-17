class MissionsController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :mission_invalid

    def create
        mission = Mission.create!( mission_params )
        render json: mission.planet, status: :created
    end

    private

    def mission_params
        params.require( :mission ).permit( :name, :scientist_id, :planet_id )
    end

    def mission_invalid invalid_mission
        render json: { errors: invalid_mission.record.errors.full_messages }, status: 422
    end
end
