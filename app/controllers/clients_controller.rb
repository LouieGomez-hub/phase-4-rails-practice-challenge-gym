class ClientsController < ApplicationController

    def show
        client = Client.find_by(id: params[:id])
        if client
            render json: client, include: :memberships
        else
            render json: { error: "Client not found" }, status: :not_found
        end
    end

end
