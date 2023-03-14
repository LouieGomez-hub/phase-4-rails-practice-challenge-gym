class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :not_found

    def create
        membership = Membership.create!( membership_params )
        render json: membership, status: :created
    end

    private

    def membership_params
        params.permit(:gym_id, :client_id, :charge)
    end

    def not_found(invalid)
        render json: { error: invalid.record.errors.full_messages }, status: 422
    end
end
