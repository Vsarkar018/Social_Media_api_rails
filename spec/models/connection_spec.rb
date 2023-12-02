require 'rails_helper'

RSpec.describe Connection, type: :model do

  describe "associations" do
    it {should belong_to(:followers).class_name(User)}
    it {should belong_to(:following).class_name(User)}
  end

  describe "operations" do
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
    end

    # it "Creates a connection" do
    #   connection = build(:connection,followers: @user1, following: @user2)
    #   expect  {connection.save}.to change(described_class, :count).by(1)
    # end
    #
    # it "reads the connection" do
    #   connection = create(:connection , following: @user2 , followers: @user1)
    #   expect(described_class.find(connection.id)).to eq(connection)
    # end

    # it 'updates a connection' do
    #   connection = create(:connection, followers: @user1, following: @user2)
    #   connection.update(followers: @user2)
    #   expect(connection.reload.followers).to eq(@user2)
    # end
    #
    # it 'destroys a connection' do
    #   connection = create(:connection, followers: @user1, following: @user2)
    #   expect { connection.destroy }.to change(described_class, :count).by(-1)
    # end
    it 'gets following of a user' do
      # connection = create(:connection, followers: @user1, following: @user2)
      @user1.follow(@user2)
      @user1.reload
      # byebug
      # expect(@user1.following).to include(@user2)
      expect(@user1.following.count).to eq(1)
    end

    pending 'gets users followed by a user' do


      expect(following_users).to include(@user2)
      expect(following_users.count).to eq(1)
    end

  end
end


# spec/models/connection_spec.rb
#
# require 'rails_helper'
#
# RSpec.describe Connection, type: :model do
#   let(:user1) { create(:user) }
#   let(:user2) { create(:user) }
#
#   describe 'Database operations' do
#     it 'creates a connection' do
#       connection = build(:connection, follower: user1, following: user2)
#       expect { connection.save }.to change(described_class, :count).by(1)
#     end
#
#     it 'reads a connection' do
#       connection = create(:connection, follower: user1, following: user2)
#       expect(described_class.find(connection.id)).to eq(connection)
#     end
#
#     it 'updates a connection' do
#       connection = create(:connection, follower: user1, following: user2)
#       connection.update(follower: user2)
#       expect(connection.reload.follower).to eq(user2)
#     end
#
#     it 'destroys a connection' do
#       connection = create(:connection, follower: user1, following: user2)
#       expect { connection.destroy }.to change(described_class, :count).by(-1)
#     end
#   end
# end
