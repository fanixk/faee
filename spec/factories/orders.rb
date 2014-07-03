FactoryGirl.define do 
  factory :order do
    address
    user
    pay_type { 'Pay on Delivery'}
  end 
end