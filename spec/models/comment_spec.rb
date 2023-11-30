require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "associations" do
    it {should belong_to(:post)}
    it {should belong_to(:user)}
  end

  describe "validations" do
    it {should validate_presence_of(:content)}
  end


  describe "Db operations " do
    before(:each) do
      @comment = create(:comment)
    end
    it "creates a comment with valid parameters" do
      comment = described_class.create(user_id: @comment.user_id, post_id: @comment.post_id, content: @comment.content)
      expect(comment).to be_valid
      expect(comment.content).to eq(@comment.content)
      expect(comment.user_id).to eq(@comment.user_id)
      expect(comment.post_id).to eq(@comment.post_id)
    end
    it "returns an error with invalid parameters" do
      comment = described_class.create(user_id: '', post_id: '', content: '')
      expect(comment).not_to be_valid
    end

    it "updates a comment with valid parameters" do
      @comment.update(content:"Updated comment!")
      expect(@comment).to be_valid
      expect(@comment.content).to eq("Updated comment!")
    end

    it "destroys a comment" do
      expect {
        @comment.destroy
      }.to change(described_class, :count).by(-1)
    end
  end
end

