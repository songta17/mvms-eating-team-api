module Api
  module V1
    class AddressSerializer < ActiveModel::Serializer
      belongs_to :restaurant

      attributes :restaurant, :street, :zipcode, :town, :country

      def restaurant
        {
          name: object.restaurant.name
        }
      end
    end
  end
end
