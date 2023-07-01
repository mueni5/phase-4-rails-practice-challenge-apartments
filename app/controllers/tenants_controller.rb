class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocesable_entity_response



    def index
        tenants = Tenant.all
        render json: tenants
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def show
        tenant = find_tenant
        render json: tenant
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update(tenant_params)
        render json: tenant
    end

    def destroy
        tenant = find_tenant
        tenant.destroy
        head :no_content
    end

    private

    def tenant_params
        params.require(:tenant).permit(:name, :rent)
    end

    def find_tenant
        Tenant.find(params[:id])
    end

    def render_not_found_response
         render json: {error:"Apartment not found"}, status: :not_found
    end

    def render_unprocesable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
