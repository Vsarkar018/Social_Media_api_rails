require 'rails_helper'

RSpec.describe User, type: :model do

  describe "associations" do
    before(:each) do
      subject { create(:user) }
    end
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
    # it { should have_many(:active_relationships).class_name('Connection').with_foreign_key('follower_id').dependent(:destroy) }
    # it { should have_many(:passive_relationships).class_name('Connection').with_foreign_key('following_id').dependent(:destroy) }
    # it { should have_many(:following).through(:passive_relationships).source(:following) }
    # it { should have_many(:followers).through(:active_relationships).source(:followers) }
    # before(:each) do
    #   @other_user = create(:user)
    #   @user = create(:user)
    # end
    # it 'follows and unfollows users' do
    #       expect(@user.following).not_to include(@other_user)
    #       byebug
    #       @user.follow( @other_user )
    #       byebug
    #       expect(@user.following).to include( @other_user )
    #       @user.unfollow( @other_user )
    #       expect(@user.following).not_to include( @other_user )
    # end
  end


  describe "DB operations" do
    before(:each) do
      @user = create(:user)
      # byebug
    end
    it "returns the user with valid parameters" do
      test_user= described_class.create(name: @user.name , email: "user@gocomet.com" , password: @user.password)
      # Byebug
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