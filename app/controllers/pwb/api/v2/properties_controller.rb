require_dependency "pwb/application_controller"

module Pwb
  class Api::V2::PropertiesController < ApplicationApiController

    def index
      @properties = Prop.all.limit(100)
      render json: @properties
    end


    def show
      @property = Prop.find(params[:id])
      render json: @property.as_json_for_admin
    end

    def update
      @property = Prop.find(params[:id])
      @property.update(property_params)
      @property.save!
      render json: @property.as_json_for_admin
    end

    def property_params
      permitted = Prop.globalize_attribute_names +
        [:street_address, :street_number,
         :postal_code, :city,
         :region, :country,
         :longitude, :latitude,
         :price_rental_monthly_current_cents, :price_sale_current_cents,
         :price_sale_original_cents, :price_rental_monthly_current_cents,
         :price_rental_monthly_original_cents, :price_rental_monthly_low_season_cents,
         :price_rental_monthly_high_season_cents, :price_rental_monthly_standard_season_cents,
         ]
      params.require(:property).permit(
        *permitted
      )
    end
  end
end