FactoryBot.define do
  factory :comment do
    association :user
    association :post
    content { "Looking nice bro" }
  end
end
