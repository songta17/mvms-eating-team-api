require 'rails_helper'

RSpec.describe Address, type: :model do
  it "is valid with a street, zipcode, town, country and restaurant_id" do
    user = FactoryBot.create(:user)
    restaurant = FactoryBot.create(:restaurant, user_id: user.id)
    address = Address.create(
      street: "19 route de Versailles",
      zipcode: 78560,
      town: "Le Port-Marly",
      country: "France",
      restaurant_id: restaurant.id
    )
    expect(address).to be_valid
  end

  describe "--street column" do 
    context "is valid" do
      it "with more than 5 characters" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, street: "3 sss-ss", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end
    end

    context "is invalid" do
      it "with a street: nil" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.build(:address, street: nil, restaurant_id: restaurant.id)
        address.valid?
        expect(address.errors["street"]).to include "can't be blank"
      end

      it "with unless than 5 characters" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.build(:address, street: "mini", restaurant_id: restaurant.id)
        address.valid?
        expect(address.errors["street"]).to include "is too short (minimum is 5 characters)"
      end
    end
  end

  describe "--zipcode column" do 
    context "is valid" do
      it "with more than 0 characters" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, zipcode: 3, restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

      it "with only number" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, zipcode: 12343, restaurant_id: restaurant.id)
        expect(address).to be_valid
      end
    end

    context "is invalid" do
      it "without zipcode" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.build(:address, zipcode: nil, restaurant_id: restaurant.id)
        address.valid?
        expect(address.errors["zipcode"]).to include "can't be blank"
      end

      it "with more than 10 characters" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.build(:address, zipcode: 12345678911, restaurant_id: restaurant.id)
        address.valid?
        expect(address.errors["zipcode"]).to include "is too long (maximum is 10 characters)"
      end

      it "with letters" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.build(:address, zipcode: "ZEGZREGR", restaurant_id: restaurant.id)
        expect(address.valid?).to eq false
      end
    end
  end

  describe "--town column" do 
    context "is valid" do
      it "with more than 3 characters" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, town: "uio", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

      it "with '" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, town: "u'io", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

      it "with ." do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, town: "u.io", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end
      
      it "with -" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, town: "u-io", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

      it "with only letters" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, town: "concon", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end
    end

    context "is invalid" do
      it "without town" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.build(:address, town: nil, restaurant_id: restaurant.id)
        address.valid?
        expect(address.errors["town"]).to include "can't be blank"
      end

      it "with only number" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.build(:address, town: 12343, restaurant_id: restaurant.id)
        expect(address.valid?).to be false
      end
    end
  end

  describe "--country column" do 
    context "is valid" do
      it "with more than 3 characters" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, country: "uio", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

      it "with '" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, country: "u'io", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

      it "with ()" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, country: "u)(io", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

      it "with ." do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, country: "u.io", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end
      
      it "with -" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, country: "u-io", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

      it "with !" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, country: "u!!!so", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

      it "with ()" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, country: "u()so", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

      it "with only letters" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.create(:address, country: "concon", restaurant_id: restaurant.id)
        expect(address).to be_valid
      end

    end

    context "is invalid" do
      it "without country" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.build(:address, country: nil, restaurant_id: restaurant.id)
        address.valid?
        expect(address.errors["country"]).to include "can't be blank"
      end

      it "with only number" do
        user = FactoryBot.create(:user)
        restaurant = FactoryBot.create(:restaurant, user_id: user.id)
        address = FactoryBot.build(:address, country: 12343, restaurant_id: restaurant.id)
        expect(address.valid?).to be false
      end
    end
  end
end
