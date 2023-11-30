FactoryBot.define do
  factory :comment do
    post { nil }
    user { nil }
    content { "MyString" }
  end
end
