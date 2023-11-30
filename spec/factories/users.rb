FactoryBot.define do
  factory :user do
    name { "Test Name" }
    sequence(:email){|n| "test.n#{n}@ gocomet.com"}
    password_digest { BCrypt::Password.create("12345") }
  end
end
