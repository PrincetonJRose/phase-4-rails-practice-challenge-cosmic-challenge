class ScientistsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :scientist_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :scientist_invalid

    def index
        render json: Scientist.all, status: :ok
    end

    def show
        scientist = Scientist.find( params[:id] )
        render json: scientist.to_json( except: [:created_at, :updated_at], include: [:planets => {except: [:created_at, :updated_at] } ] ), status: :ok
    end

    def create
        scientist = Scientist.create!( scientist_params )
        render json: scientist, status: :created
    end

    def update
        scientist = Scientist.find( params[:id] )
        scientist.update!( scientist_params )
        render json: scientist, status: :accepted
    end

    # def update
    #     scientist = Scientist.find_by( id: params[:id] )
    #     if scientist
    #         scientist.update( scientist_params )
    #         if scientist.valid?
    #             render json: scientist, status: :accepted
    #         else
    #             scientist_invalid scientist
    #         end
    #     else
    #         scientist_not_found
    #     end
    # end

    def destroy
        scientist = Scientist.find( params[:id] )
        # scientist.missions.destroy_all
        scientist.destroy
        head :no_content
    end

    private

    def scientist_params
        params.require( :scientist ).permit( :name, :field_of_study, :avatar )
    end

    def scientist_not_found
        render json: { errors: ["Scientist was not found in the database. 🧑‍🔬"] }, status: 404
    end

    def scientist_invalid invalid_scientist
        render json: { errors: invalid_scientist.record.errors.full_messages }, status: 422
    end

end
