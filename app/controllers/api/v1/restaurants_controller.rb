module Api
  module V1
    class RestaurantsController < ApplicationController

      before_action :set_restaurant, only: [:show, :update, :destroy]
      before_action :authenticate_user!, except: [:index, :show]

      # GET /restaurants
      def index
        @restaurants = Restaurant.all.includes(:user)
        @restaurants = @restaurants.authored_by(params[:author]) if params[:author].present?
        @restaurants = @restaurants.order(created_at: params[:order] || "asc").offset(params[:offset] || 0).limit(params[:limit] || 5)
        # @restaurants_info = @restaurants.info
        render json: {
          # info: ActiveModelSerializers::SerializableResource.new(@restaurants_info, each_serializer: InfoSerializer),
          code: 200,
          message: 'Restaurants list fetched successfully',
          restaurants: ActiveModelSerializers::SerializableResource.new(@restaurants, each_serializer: RestaurantSerializer)
        }
      end

      # GET /restaurants/ID
      def show
        render json: {
          code: 200,
          message: 'Restaurant returns successfully.',
          restaurants: ActiveModelSerializers::SerializableResource.new(@restaurant, serializer: RestaurantSerializer)
        }
      end

      # POST /restaurants
      def create
        @restaurant = Restaurant.new(restaurant_params)

        if @restaurant.save
          render json: {
            code: 201,
            message: 'Restaurant created successfully.',
            restaurants: ActiveModelSerializers::SerializableResource.new(@restaurant, serializer: RestaurantSerializer)
          }, status: 201
        else
          render json: {
            code: 422,
            message: 'Restaurant creating failed.',
            errors: @restaurant.errors
          }, status: 422
        end
      end

      # PUT /restaurants/ID
      def update
        if @restaurant.update(restaurant_params)
          render json: {
            code: 200,
            message: 'Restaurant updated successfully.',
            restaurants: ActiveModelSerializers::SerializableResource.new(@restaurant, serializer: RestaurantSerializer)
          }, status: 200
        else
          render json: {
            code: 422,
            message: 'Restaurant updating failed.',
            errors: @restaurant.errors
          }, status: 422
        end
      end

      # DELETE /restaurants/ID
      def destroy
        @restaurant.destroy
        render json: {
          code: 204,
          message: 'Restaurant Deleted successfully.'
        }, status: 204
      end

      private

      def set_restaurant
        @restaurant = Restaurant.find(params[:id])
      end

      def restaurant_params
        params.require(:restaurant).permit(:name, :user_id)
      end
    end
  end
end
