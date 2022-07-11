FactoryBot.define do
  LIST_ZIPCODE = (75001..75020).to_a
  factory :address do
    sequence(:street) { |n| "#{Faker::Address.street_name} #{n}" }
    sequence(:zipcode) { |n| LIST_ZIPCODE.sample }
    town { "Paris" }
    country { "France" }
    association :restaurant
  end
end
