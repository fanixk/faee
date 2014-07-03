FactoryGirl.define do 
  factory :page do
    sequence(:name) { |n| "page#{n}" } 
    sequence(:content) { |n| "content#{n}" }
    is_published { true }
    in_menu { true }
  end 
end