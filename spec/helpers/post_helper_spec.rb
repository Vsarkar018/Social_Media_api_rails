require 'rails_helper'

RSpec.describe V1::Helpers::PostHelper, type: :helper do
  before(:each) do
    @post = create(:post)
  end
  describe "Create Post" do
    pending "returns the post with valid parameters" do
      data = { caption: @post.caption }.to_json
      params = { data: data, images: @post.images }
      expect(described_class.new.create_post(params,@post.user_id)).to change(Post, :count).by(1)
      # test_post = described_class.new.create_post(params, @post.user_id)
      post = Post.last
      expect(post.caption).to eq(caption)
      expect(post.user_id).to eq(user_id)
      expect(post.images).to include(an_instance_of(String))
      FileUtils.rm_rf(File.join('public', 'uploads'))
    end
    it "return error with invalid parameters" do
      params = {images:'', caption:""}
      expect {described_class.new.create_post(params,@post.user_id)}.to raise_error(StandardError)
    end
  end
  describe "get post" do
    it "returns post with valid parameters" do
      test_post = described_class.new.get_post(@post.id)
      expect(test_post).to be_valid
      expect(test_post).to eq(@post)
    end
    it "returns nil for a nonexistent post" do
      test_post = described_class.new.get_post(9999) # Assuming 9999 is not a valid post ID
      expect(test_post).to be_nil
    end
  end

  describe "Update Post" do
    pending "updates a post with valid parameters" do
      params = { caption: "Updated caption", images: ["new_image_url"] }
      updated_post = described_class.new.update_post(@post.id, params)
      expect(updated_post).to be_valid
      expect(updated_post.caption).to eq("Updated caption")
      expect(updated_post.images).to eq(["new_image_url"])
    end
    it "raises an error for invalid parameters" do
      params = { caption: "", images: "" }
      expect { described_class.new.update_post(@post.id, params) }.to raise_error(StandardError)
    end
  end

  describe "Delete Post" do
    it "deletes a post with a valid ID" do
      expect { described_class.new.delete_post(@post.id) }.to change(Post, :count).by(-1)
    end

    it "raises an error for a nonexistent post" do
      expect { described_class.new.delete_post(9999) }.to raise_error(StandardError)
    end
  end

  describe "Get All Posts of User" do
    pending "returns all posts of a user with valid user_id" do
      post1 = create(:post, user_id: @post.user_id)
      post2 = create(:post, user_id: @post.user_id)
      posts = described_class.new.get_all_post_of_user(@post.user_id)
      expect(posts).to be_an(Array)
    end
    it "returns an empty array for an invalid user_id" do
      posts = described_class.new.get_all_post_of_user(-1) # Assuming -1 is an invalid user_id
      expect(posts).to be_empty
    end
  end

end
