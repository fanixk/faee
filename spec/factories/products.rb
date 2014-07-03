FactoryGirl.define do 
  factory :product do |f|
    f.sequence(:name) { |n| "product#{n}" }
    f.price { rand(100)+1 }
    f.category
  end 
end