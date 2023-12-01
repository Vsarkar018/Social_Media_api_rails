FactoryBot.define do
  factory :post do
    association :user
    caption { "Hey this is my first post" }
    images { %w[image_url1 image_url2] }
    # after(:build) do |post|
    #   post.images.attach(
    #       Rack::Test::UploadedFile.new(
    #         Rails.root.join('spec', 'testfiles','example.jpg'), 'image/jpg'
    #       )
    #   )
    # end
  end
end
