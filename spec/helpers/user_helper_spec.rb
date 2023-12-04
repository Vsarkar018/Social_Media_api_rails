require 'rails_helper'

RSpec.describe V1::Helpers::UserHelper, type: :helper do
  describe "#get_user" do
    it "returns nil for a nonexistent email" do
      result = described_class.new.get_user("nonexistent@example.com")
      expect(result).to be_nil
    end

    it "raises an error for unexpected errors" do
      allow(User).to receive(:find_by_id).and_raise(StandardError, "Unexpected error")
      expect { described_class.new.get_user("test@example.com") }.to raise_error(StandardError, "Unexpected error")
    end
    before(:each) do ||
      @this_user = create(:user)
    end
    it "returns the user with a valid email" do
      result = described_class.new.get_user(@this_user.id)
      expect(result).to eq(@this_user)
    end
  end

  describe "Follows a user" do
    before(:each) do
      @this_user = create(:user)
      @other_user = create(:user)
    end
    it "follows the other user" do
      described_class.new.follow_user(@this_user,@other_user)
      expect(@this_user.following).to include(@other_user)
    end
  end
end
