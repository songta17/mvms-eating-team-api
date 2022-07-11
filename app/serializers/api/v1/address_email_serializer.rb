module Api
  module V1
    class AddressEmailSerializer < ActiveModel::Serializer
      attributes :restaurant, :street, :zipcode, :town, :country, :user
      has_one :restaurant

      def restaurant
        {
          name: object.restaurant.name
        }
      end

      def user
        { email: object.restaurant.user.email }
      end

      # def user
      #   {
      #     email: object.restaurant.user.email
      #   }
      # end
    end
  end
end
