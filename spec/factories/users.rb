FactoryBot.define do
  factory :user do
    name { "Test Name" }
    sequence(:email){|n| "test.n#{n}@gocomet.com"}
    password {"12345678"}




  end
end
