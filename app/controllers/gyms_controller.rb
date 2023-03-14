class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :not_found

    def show
        gym = Gym.find_by(id: params[:id])
        if gym
            render json: gym
        else
            render json: { error: "Gym not found" }, status: :not_found
        end
    end

    def destroy
        gym = Gym.find_by(id: params[:id])
        if gym
            gym.destroy
            head :no_content
        else
            render json: { error: "Gym not found" }, status: :not_found
        end
    end

    def index
        gym = Gym.all
        render json: gym
    end

    def update
        gym = Gym.find(params[:id])
        gym.update!(gym_params)
        render json: gym
    end

    private

    def gym_params
        params.permit(:name, :address)
    end

    def not_found(invalid)
        render json: { error: invalid.record.errors.full_messages }, status: 422
    end 

end
