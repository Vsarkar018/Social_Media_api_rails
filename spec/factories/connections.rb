FactoryBot.define do
  factory :connection do
    association :follower, factory: :user
    association :following, factory: :user
  end
end
