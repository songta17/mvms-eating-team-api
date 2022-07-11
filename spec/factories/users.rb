FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "kipo_#{n}.cto@gmail.com" }
    password { 'azerty1' }
  end
end
