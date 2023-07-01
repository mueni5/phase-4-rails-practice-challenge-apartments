class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocesable_entity_response



    def index
        leases = Lease.all
        render json: leases
    end

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def show
        lease = find_lease
        render json: lease
    end

    def update
        lease = Lease.find(params[:id])
        lease.update(lease_params)
        render json: lease
    end

    def destroy
        lease = find_lease
        lease.destroy
        head :no_content
    end

    private

    def lease_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end

    def find_lease
        Lease.find(params[:id])
    end

    def render_not_found_response
         render json: {error:"Apartment not found"}, status: :not_found
    end

    def render_unprocesable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
