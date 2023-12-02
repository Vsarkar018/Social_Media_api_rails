FactoryBot.define do
  factory :post do
    association :user
    caption { "Hey this is my first post" }
    images { %w[image_url1 image_url2] }
    # after(:build) do |post|
    #   image = {
    #     tempfile: File.open(Rails.root.join('spec', 'files', 'example.jpg')),
    #     filename: 'example.jpg',
    #     type: 'image/jpg'
    #   }
    #   post.images = image
    # end
  end
end
