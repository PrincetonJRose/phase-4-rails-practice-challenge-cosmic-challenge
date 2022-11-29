class ScientistsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        scientists = Scientist.all
        render json: scientists, except: [:created_at, :updated_at], status: :ok
    end

    def show
        scientist = Scientist.find( params[:id] )
        render json: scientist, except: [:created_at, :updated_at], include: :planets, status: :ok
    end

    def create
        scientist = Scientist.create!( scientist_params )
        render json: scientist, status: :created
    end

    def update
        scientist = Scientist.find( params[:id] )
        scientist.update( scientist_params )
        render json: scientist, except: [:created_at, :updated_at], status: :accepted
    end

    def destroy
        scientist = Scientist.find( params[:id] )
        scientist.destroy
        render json: { messages: ['Scientist was successfully removed from duty.'] }, status: :ok
    end

    private

    def scientist_params
        params.require( :scientist ).permit( :name, :field_of_study, :avatar )
    end

    def render_not_found_response
        render json: { errors: ['Scientest not found'] }, status: :not_found
    end

    def render_unprocessable_entity_response invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
