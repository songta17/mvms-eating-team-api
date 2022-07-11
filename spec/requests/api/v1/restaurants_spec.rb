require 'rails_helper'

RSpec.describe Api::V1::RestaurantsController, type: :request do

  describe "GET /index" do
    it "return http successfully" do
      get "/api/v1/restaurants.json"
      expect(response).to have_http_status "200"
    end

    it "returns all restaurants" do
      restaurants = FactoryBot.create_list(:restaurant, 5)
      get "/api/v1/restaurants.json"
      expect(JSON.parse(response.body)["restaurants"].length).to eq 5
    end
    
    it "JSON body response contains expected restaurants attributes" do
      user = FactoryBot.create(:user)
      restaurant_goku = Restaurant.create(name: "Goku", user_id: user.id)
      restaurant_bao_king = Restaurant.create(name: "Bao King", user_id: user.id)
      get "/api/v1/restaurants.json"
      json_response = JSON.parse(response.body)["restaurants"]
      expect(json_response.first['name']).to eq('Goku')
      expect(json_response.last['name']).to eq('Bao King')
    end

    # test params
    # author
    context "Filtered" do
      it "returns restaurants filter by author" do
        user = FactoryBot.create(:user)
        restaurants = FactoryBot.create_list(:restaurant, 5, user_id: user.id)
        second_user = FactoryBot.create(:user)
        restaurants = FactoryBot.create_list(:restaurant, 10, user_id: second_user.id)
        get "/api/v1/restaurants?author=#{user.email}"
        expect(JSON.parse(response.body)["restaurants"].length).to eq 5
      end
    end

    context "PARAMS" do
      context "returns restaurant with params asc/desc" do
        it "default order" do
          FactoryBot.create(:user)
          restaurant_first = FactoryBot.create(:restaurant, name: "first")
          get "/api/v1/restaurants"
          restaurant_second = FactoryBot.create(:restaurant, name: "second")
          get "/api/v1/restaurants"
          expect(JSON.parse(response.body)["restaurants"].first["name"]).to eq "first"
          expect(JSON.parse(response.body)["restaurants"].last["name"]).to eq "second"
          # expect(JSON.parse(response.body)["restaurants"].to include("cac ss") 
        end

        it "order value = desc" do
          FactoryBot.create(:user)
          restaurant_first = FactoryBot.create(:restaurant, name: "first")
          get "/api/v1/restaurants"
          restaurant_second = FactoryBot.create(:restaurant, name: "second")
          get "/api/v1/restaurants?order=desc"
          expect(JSON.parse(response.body)["restaurants"].last["name"]).to eq "first"
          expect(JSON.parse(response.body)["restaurants"].first["name"]).to eq "second"
          # expect(JSON.parse(response.body)["restaurants"].to include("cac ss") 
        end
      end

      context "returns restaurants order with params limit" do
        it "default limit" do
          user = FactoryBot.create(:user)
          restaurants = FactoryBot.create_list(:restaurant, 20, user_id: user.id)
          get "/api/v1/restaurants"
          expect(JSON.parse(response.body)["restaurants"].length).to eq 5
        end

        it "limit value: 2" do
          user = FactoryBot.create(:user)
          restaurants = FactoryBot.create_list(:restaurant, 5, user_id: user.id)
          get "/api/v1/restaurants?limit=2"
          expect(JSON.parse(response.body)["restaurants"].length).to eq 2
        end
      end

      context "returns restaurants order with params offset" do
        it "default offset" do
          user = FactoryBot.create(:user)
          restaurants = FactoryBot.create_list(:restaurant, 3, user_id: user.id)
          get "/api/v1/restaurants"
          expect(JSON.parse(response.body)["restaurants"].length).to eq 3
        end

        it "offset value: 2" do
          user = FactoryBot.create(:user)
          restaurants = FactoryBot.create_list(:restaurant, 5, user_id: user.id)
          get "/api/v1/restaurants?offset=2"
          expect(JSON.parse(response.body)["restaurants"].length).to eq 3
        end
      end
    end
  end

  describe "GET /show " do
    it "returns http successfully" do
      restaurant = FactoryBot.create(:restaurant)
      get "/api/v1/restaurants/#{restaurant.id}.json"
      expect(response).to have_http_status "200"
    end
  end

  describe "POST /create" do
    context "as a guest" do
      it "returns redirect code status 302" do   
        user = FactoryBot.create(:user)
        post "/api/v1/restaurants", params: {
          restaurant: { name: "Restaurant de la maree", user_id: user.id }
        }
        expect(response.status).to eq(302) # redirect 
      end
    end
    context "Authenticated" do
      context "allow " do
        it "saving with correct restaurant attributes " do   
          user = FactoryBot.create(:user)
          sign_in user
          post "/api/v1/restaurants", params: {
            restaurant: { name: "Restaurant de la maree", user_id: user.id }
          }
          expect(response.status).to eq(201)
        end
  
        it "increasing number of restaurants" do
          user = FactoryBot.create(:user)
          sign_in user
          post "/api/v1/restaurants", params: {
            restaurant: { name: "Burger King", user_id: user.id }
          }
          sign_in user
          post "/api/v1/restaurants", params: {
            restaurant: { name: "Mac Donald", user_id: user.id }
          }
          get "/api/v1/restaurants.json"
          expect(JSON.parse(response.body)["restaurants"].length).to eq 2
        end
      end
  
      context "does not allow " do
        it "invalid restaurant attributes" do
          user = FactoryBot.create(:user)
          sign_in user
          post "/api/v1/restaurants", params: {
            restaurant: { name: "x", user_id: user.id }
          }
          expect(response.status).to eq(422) # unprocessable_entity
          get "/api/v1/restaurants.json"
          expect(JSON.parse(response.body)["restaurants"].length).to eq 0
        end
      end
    end
  end

  describe "PUT /restaurants/ID" do
    context "As a Guest" do
      it "redirect with the cde 302" do
        restaurant = FactoryBot.create(:restaurant)
        put "/api/v1/restaurants/#{restaurant.id}", params: {
          restaurant: { name: "Restaurant de la maree" }
        }
        expect(response.status).to eq(302) # redirect
      end
    end

    context "Authenticated" do
      it "valid the EDIT with correct restaurant attributes" do   
        restaurant = FactoryBot.create(:restaurant)
        sign_in restaurant.user
        put "/api/v1/restaurants/#{restaurant.id}", params: {
          restaurant: { name: "Restaurant de la maree" }
        }
        expect(response.status).to eq(200)
      end

      it "increasing of the restaurant number" do
        user = FactoryBot.create(:user)
        sign_in user
        post "/api/v1/restaurants", params: {
          restaurant: { name: "Mac Donald", user_id: user.id }
        }
        sign_in user
        post "/api/v1/restaurants", params: {
          restaurant: { name: "Burger King", user_id: user.id }
        }
        get "/api/v1/restaurants.json"
        expect(JSON.parse(response.body)["restaurants"].length).to eq 2
      end

      it "returns unprocessable_entity with invalid attributes" do
        restaurant = FactoryBot.create(:restaurant, name: "Le Pavillon")
        sign_in restaurant.user
        put "/api/v1/restaurants/#{restaurant.id}", params: {
          restaurant: { name: "x", user_id: restaurant.id }
        }
        expect(response.status).to eq(422) # unprocessable_entity
      end

      it "Doesn't EDIT restaurant with invalid attributes" do
        restaurant = FactoryBot.create(:restaurant, name: "Le Pavillon")
        sign_in restaurant.user
        put "/api/v1/restaurants/#{restaurant.id}", params: {
          restaurant: { name: "x" }
        }
        get "/api/v1/restaurants/#{restaurant.id}.json"
        json_response = JSON.parse(response.body)["restaurants"]
        expect(json_response['name']).to eq('Le Pavillon')
      end
    end
  end

  describe "DELETE /destroy" do
    context "as a guest" do
      it 'returns status code 302 (redirected code status)' do
        restaurant = FactoryBot.create(:restaurant)
        delete "/api/v1/restaurants/#{restaurant.id}"
        expect(response).to have_http_status(302) # redirect
      end
    end

    context "Authenticated" do
      it 'returns status code 204' do
        restaurant = FactoryBot.create(:restaurant)
        user = FactoryBot.create(:user)
        sign_in user
        delete "/api/v1/restaurants/#{restaurant.id}"
        expect(response).to have_http_status(204)
      end
    end
  end


  #   # context "without an existing ID" do
  #   #   it 'returns status code 404' do
  #   #     delete "/api/v1/restaurants/100"
  #   #     # puts response
  #   #     expect(response).to include "ActiveRecord::RecordNotFound:
  #   #     Couldn't find Restaurant with 'id'=100"
  #   #     # expect(response).to have_http_status(404)
  #   #   end
  #   # end


  # end
end
