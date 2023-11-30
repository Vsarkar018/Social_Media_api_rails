FactoryBot.define do
  factory :post do
    association :user
    caption { "Hey this is my first post" }
    images { %w[image_url1 image_url2] } # Adjust the image URLs as needed
  end
end
