require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UserHelper. For example:
#
# describe UserHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
      @user = create(:user)
    end
    it "returns the user with a valid email" do
      result = described_class.new.get_user(@user.id)
      expect(result).to eq(@user)
    end

  end
end
