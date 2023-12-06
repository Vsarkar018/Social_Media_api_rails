require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "associations" do
    it {should have_many(:comments).dependent(:destroy)}
    it {should belong_to(:user)}
  end


  describe "DB operations" do
    before :each do
      @post = create(:post)
    end
    it "Create a post with valid parameters" do
      test_post = described_class.create(caption: @post.caption, images: @post.images, user_id: @post.user_id)
      expect(test_post).to be_valid
      expect(test_post.caption).to eq(@post.caption)
      expect(test_post.images).to eq(@post.images)
      expect(test_post.user_id).to eq(@post.user_id)
    end
    it "should return error with invalid parameters" do
      test_post = described_class.create(caption: '', images: '', user_id: -1)
      expect(test_post).not_to be_valid
    end


    it "update post with valid parameters" do
      @post.update(caption: "updated_comment", images: %w[adhakhda adhaksas])
      expect(@post).to be_valid
      expect(@post.caption).to eq("updated_comment")
      expect(@post.images).to eq(%w[adhakhda adhaksas])
    end

    it "destroys a post" do
      expect {
        @post.destroy
      }.to change(described_class, :count).by(-1)
    end
  end
end
