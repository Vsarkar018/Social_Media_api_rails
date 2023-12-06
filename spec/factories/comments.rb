FactoryBot.define do
  factory :comment do
    association :user
    association :post
    content {"That is a nice comment" }
  end
end
