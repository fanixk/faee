require 'faker'

FactoryGirl.define do 
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.user_name }
    email { Faker::Internet.email}
    password { 'secretsecret' }
    trait :via_facebook do
      provider 'facebook'
      uid { rand(100000) }
      password { '' }
    end
    trait :via_twitter do
      provider 'twitter'
      uid { rand(100000) }
      password { '' }
    end
  end
end