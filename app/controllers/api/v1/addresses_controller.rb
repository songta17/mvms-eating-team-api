module Api
  module V1
    class AddressesController < ApplicationController
      before_action :set_address, only: [:show, :update, :destroy]
      before_action :authenticate_user!, except: [:index, :show]

      # GET /addresses
      def index
        @addresses = Address.all.includes(:restaurant)
        @addresses = @addresses.filter_by_country(params[:country]) if params[:country].present?
        @addresses = @addresses.filter_by_zipcode(params[:zipcode]) if params[:zipcode].present?
        @addresses = @addresses.filter_by_country(params[:town]) if params[:town].present?
        @addresses = @addresses.order(created_at: params[:order] || "asc").offset(params[:offset] || 0).limit(params[:limit] || 5)
        render json: {
          code: 200,
          message: 'Addresses list fetched successfully',
          address: ActiveModelSerializers::SerializableResource.new(@addresses, each_serializer: AddressSerializer)
        }
      end

      # GET /addresses/ID
      def show
        render json: {
          code: 200,
          message: 'Address returns successfully.',
          address: ActiveModelSerializers::SerializableResource.new(@address, serializer: AddressEmailSerializer)
        }
      end

      # POST /addresses
      def create
        @address = Address.new(address_params)

        if @address.save
          render json: {
            code: 201,
            message: 'Address created successfully.',
            address: ActiveModelSerializers::SerializableResource.new(@address, serializer: AddressSerializer)
          }, status: 201
        else
          render json: {
            code: 422,
            message: 'Address creating failed.',
            errors: @address.errors
          }, status: 422
        end
      end

      # PUT /addresses/ID
      def update
        if @address.update(address_params)
          render json: {
            code: 200,
            message: 'Address updated successfully.',
            addresses: ActiveModelSerializers::SerializableResource.new(@address, serializer: AddressSerializer)
          }, status: 200
        else
          render json: {
            code: 422,
            message: 'Address updating failed.',
            errors: @address.errors
          }, status: 422
        end
      end

      # DELETE /addresses/ID
      def destroy
        @address.destroy
        render json: {
          code: 204,
          message: 'Address Deleted successfully.'
        }, status: 204
      end

      private

      def set_address
        @address = Address.find(params[:id])
      end

      def address_params
        params.require(:address).permit(:street, :zipcode, :town, :country, :restaurant_id)
      end
    end
  end
end
