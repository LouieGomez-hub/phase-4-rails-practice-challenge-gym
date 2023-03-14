class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :not_found

    def show
        client = Client.find_by(id: params[:id])
        if client
            render json: client, include: :memberships
        else
            render json: { error: "Client not found" }, status: :not_found
        end
    end

    def index
        client = Client.all
        render json: client
    end

    def update
        client = Client.find(params[:id])
        client.update!(client_params)
        render json: client
    end

    private

    def client_params
        params.permit(:name, :age)
    end

    def not_found(invalid)
        render json: { error: invalid.record.errors.full_messages }, status: 422
    end 
end
