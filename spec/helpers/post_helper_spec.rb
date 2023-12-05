require 'rails_helper'

RSpec.describe V1::Helpers::PostHelper, type: :helper do
  before(:each) do
    @post = create(:post)
  end
  describe "Create Post" do
    let(:valid_params) do
      {
        data: { caption: 'Test Caption' }.to_json,
        images: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'files', 'example.jpg'), 'image/jpeg')
      }
    end
    it "returns the post with valid parameters" do
      allow(Post).to receive(:new).and_call_original
      allow(ImageService).to receive(:save_image).and_return('/spec/files/example.jpg')
      expect do
        result = helper.create_post(valid_params, @post.user_id)
        expect(result).to be_an_instance_of(Post)
        expect(result.caption).to eq('Test Caption')
        expect(result.user_id).to eq(@post.user_id)
        expect(result.images).to eq(['/spec/files/example.jpg'])
      end.to change(Post, :count).by(1)
      post = Post.last
      expect(post.caption).to eq('Test Caption')
      expect(post.user_id).to eq(@post.user_id)
      expect(post.images).to eq(['/spec/files/example.jpg'])
    end
    it "return error with invalid parameters" do
      params = {images:'', caption:""}
      expect {helper.create_post(params,@post.user_id)}.to raise_error(StandardError)
    end
  end
  describe "get post" do
    it "returns post with valid parameters" do
      test_post = helper.get_post(@post.id)
      expect(test_post).to be_valid
      expect(test_post).to eq(@post)
    end
    it "returns nil for a nonexistent post" do
      test_post = helper.get_post(9999) # Assuming 9999 is not a valid post ID
      expect(test_post).to be_nil
    end
  end

  describe "Update Post" do
    it "updates a post with valid parameters" do
      params = { caption: "Updated caption", id: @post.id }
      updated_post = helper.update_post(params)
      expect(updated_post).to be_valid
      expect(updated_post.caption).to eq("Updated caption")
    end
    it "raises an error for invalid parameters" do
      params = { caption: "", id: -1}
      expect { helper.update_post(params) }.to raise_error(StandardError)
    end
  end

  describe "Delete Post" do
    it "deletes a post with a valid ID" do
      expect { helper.delete_post(@post.id) }.to change(Post, :count).by(-1)
    end

    it "raises an error for a nonexistent post" do
      expect { helper.delete_post(9999) }.to raise_error(StandardError)
    end
  end

  describe "Get All Posts of User" do
        it "returns all posts of a user with valid user_id" do
          post1 = create(:post, user_id: @post.user_id)
          post2 = create(:post, user_id: @post.user_id)
          posts = helper.get_all_post_of_user(@post.user_id)
          posts.each do |post|
            expect(post).to be_an_instance_of(Post)
          end
        end
    it "returns an empty array for an invalid user_id" do
      posts = helper.get_all_post_of_user(-1) # Assuming -1 is an invalid user_id
      expect(posts).to be_empty
    end
  end
end