require 'rails_helper'

RSpec.describe User, type: :model do

  describe "associations" do

    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:comments) }
    # it { is_expected.to have_many(:connections).with_foreign_key('follower_id')}
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_length_of(:name).is_at_least(3).is_at_most(20)}


    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_least(3).is_at_most(50) }
    # it { should validate_uniqueness_of(:email).case_insensitive}
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }


    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should have_secure_password }
    #
    it { should have_many(:this_user).class_name('Connection').with_foreign_key('follower_id').dependent(:destroy) }
    it { should have_many(:other_user).class_name('Connection').with_foreign_key('following_id').dependent(:destroy) }
    it { should have_many(:following).through(:this_user).source(:following) }
    it { should have_many(:followers).through(:other_user).source(:followers) }
    before(:each) do
      @other_user = create(:user)
      @this_user = create(:user)
    end
    it 'follows and unfollows users' do
      @this_user.follow(@other_user)
      expect(@this_user.following).to include(@other_user)
      @this_user.unfollow(@other_user)
      expect(@this_user.following).not_to include(@other_user)
    end

  end


  describe "DB operations" do
    before(:each) do
      @user = create(:user)
    end
    it "returns the user with valid parameters" do
      test_user= described_class.create(name: @user.name , email: "user@gocomet.com" , password: @user.password)
      expect(test_user).to be_valid
      expect(test_user.name).to eq(@user.name)
      expect(test_user.email).to eq("user@gocomet.com")
      expect(test_user.password).to eq(@user.password)
    end

    it "updates a user with valid parameters" do
      @user.update(name: "Updated user")
      expect(@user.reload.name).to eq("Updated user")
    end


    it "destroys a user" do
      expect {
        @user.destroy
      }.to change(described_class, :count).by(-1)
    end
  end
end