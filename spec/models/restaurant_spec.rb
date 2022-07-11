require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context "is valid " do
    it "with a name" do
      restaurant = FactoryBot.create(:restaurant)
      expect(restaurant).to be_valid
    end

    it "with a name containing a space \" \"" do
      restaurant = FactoryBot.create(:restaurant, name: "Blind Bordeaux")
      expect(restaurant).to be_valid
    end
    
    it "with a name containing a apostrophe \"'\"" do
      restaurant = FactoryBot.create(:restaurant, name: "Blind's Bordeaux")
      expect(restaurant).to be_valid
    end

    it "with a name containing a dot \".\"" do
      restaurant = FactoryBot.create(:restaurant, name: "Mr. Bordeaux")
      expect(restaurant).to be_valid
    end

    it "with a name containing a dot \"&\"" do
      restaurant = FactoryBot.create(:restaurant, name: "Mr& Bordeaux")
      expect(restaurant).to be_valid
    end

    it "with a name containing a number \"4\"" do
      restaurant = FactoryBot.create(:restaurant, name: "Mr4 Bordeaux")
      expect(restaurant).to be_valid
    end

    it "with a name containing upercase name" do
      restaurant = FactoryBot.create(:restaurant, name: "BORDEAUX")
      expect(restaurant).to be_valid
    end

    it "with a name containing dwncase name" do
      restaurant = FactoryBot.create(:restaurant, name: "bordeaux")
      expect(restaurant).to be_valid
    end
  end

  context "is invalid " do
    it "without a name" do
      restaurant = FactoryBot.build(:restaurant, name: nil)
      restaurant.valid?
      expect(restaurant.errors["name"]).to include("can't be blank")
    end

    it "with a special characters" do
      restaurant = FactoryBot.build(:restaurant, name: "-")
      restaurant.valid?
      expect(restaurant.errors["name"]).to include("only allows letters, numbers, space and apostrophe!")
    end
  end

  context "not allow " do
    it "a existing name" do
      user = FactoryBot.create(:user)
      restaurant_one = Restaurant.create(
        name: "Goku", 
        user_id: user.id
        )
      restaurant = Restaurant.new(
        name: "Goku", 
        user_id: user.id
      )
      restaurant.valid?
      expect(restaurant.errors[:name]).to include 'has already been taken'
    end
    
    it "a name under 3 characters" do
      restaurant = FactoryBot.build(:restaurant, name: "ma")
      restaurant.valid?
      expect(restaurant.errors[:name]).to include 'is too short (minimum is 3 characters)'
    end
  end
end
