require 'faker'

FactoryGirl.define do 
  factory :address do |f| 
    f.label { Faker::Name.first_name } 
    f.street_name { Faker::Address.street_name }
    f.street_num { rand(100) }
    f.phone { rand(100000000) }
    f.region { Faker::Address.state }
    f.zipcode { Faker::Address.zip }
    f.user
  end 
end