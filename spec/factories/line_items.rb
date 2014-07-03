FactoryGirl.define do 
  factory :line_item do
    cart
    product
    order
  end 
end