FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |n| "#{Faker::Restaurant.name} #{n}" }
    association :user
  end
end
