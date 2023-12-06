require 'rails_helper'

RSpec.describe V1::Helpers::CommentsHelper, type: :helper do
  before(:each) do
    @comment = create(:comment)
  end
  describe "Create Comment" do
    it "returns the valid response" do
      result = helper.create_comment(@comment.content, @comment.post_id, @comment.user_id)
      expect(result).to be_an_instance_of(Comment)
      expect(result.content).to eq(@comment.content)
      expect(result.post_id).to eq(@comment.post_id)
      expect(result.user_id).to eq(@comment.user_id)
    end

    it "returns nil with invalid parameter" do
      expect { helper.create_comment('','','') }.to raise_error(StandardError)
    end
  end

  describe "Edit the comment" do
    it "returns the updated Comment" do
      helper.update_comment("Updated Comment", @comment.id)
      @comment.reload
      expect(@comment.content).to eq("Updated Comment")
    end

    it "returns the error for empty content" do
      expect { helper.update_comment("", @comment.id) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "reads the comment" do
    it "returns a particular comment" do
      allow(RedisService).to receive(:get_key).with("comment:#{@comment.id}").and_return(@comment)
      expect(Comment).not_to receive(:find_by_id)
      res = helper.get_comment(@comment.id)
      expect(res).to eq(@comment)
    end
    pending 'returns the comment from the database' do
      allow(RedisService).to receive(:get_key).with("comment:#{@comment.id}").and_return(nil)
      expect(Comment).to receive(:find_by_id).with(@comment.id) do
        result = Comment.find_by_id(@comment.id)
        result
      end.and_return(@comment)

      result = helper.get_comment(@comment.id)
      expect(result).to eq(@comment)
    end
    it "returns the error with invalid Comment id" do
      res = helper.get_comment(-1)
      expect(res).to be_nil
    end
  end

  describe "Get all comments of the post" do
    it "returns the array of comments of the post" do
      res = helper.get_all_comments_of_post(@comment.post_id)
      expect(res.size).to eq(1)
      end
    it "returns an empty array when the post doesn't exist" do
        res = helper.get_all_comments_of_post(-1)
        expect(res).to be_empty
      end
  end

  describe "Delete the comment" do
    it "deletes the comment with valid id" do
      expect { helper.delete_comment(@comment.id) }.to change(Comment, :count).by(-1)
    end
  end
end
