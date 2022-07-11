module Api
  module V1
    class RestaurantSerializer < ActiveModel::Serializer
      attributes :name, :user

      belongs_to :user

      def user
        {
          email: object.user.email
        }
      end
    end
  end
end
