FactoryBot.define do
  factory :connection do
    association :follower_id , factory: :user
    association :following_id , factory: :user
  end
end
