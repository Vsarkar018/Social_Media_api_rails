FactoryBot.define do
  factory :user do
    name { "Test Name" }
    sequence(:email){|n| "test.n#{n}@gocomet.com"}
    password {"12345678"}


    # transient do
    #   followers { [] }
    # end
    # # after(:create) do |user, evaluator|
    # #   evaluator.followers.each do |follower|
    # #     user.follow(follower)
    # #   end
    # # end
    # # trait :follow do
    # #   after(:create) do |user, _evaluator|
    # #     # Example: Follow a default user
    # #     user.follow(create(:user))
    # #   end
    # # end

  end
end
