require 'faker'

FactoryGirl.define do 
  factory :setting do |f| 
    f.key { Faker::Internet.user_name } 
    f.value { Faker::Internet.user_name }
  end 
end