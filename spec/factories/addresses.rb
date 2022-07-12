List = [75001, 75002, 75003, 75004, 75005, 75006, 75007, 75008, 75009, 75010, 75011, 75012, 75013, 75014, 75015, 75016, 75017, 75018, 75019, 75020]

FactoryBot.define do
  factory :address do
    sequence(:street) { |n| "#{Faker::Address.street_name} #{n}" }
    sequence(:zipcode) { |n| List.sample }
    town { "Paris" }
    country { "France" }
    association :restaurant
  end
end
