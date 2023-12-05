require 'rails_helper'

RSpec.describe V1::Helpers::AuthHelper, type: :helper do
  before :each do
    @user = create(:user)
  end
  describe "User Signup" do

    it "should return valid user" do
      params = {name: @user.name , email: "user@gmail.com" , password: @user.password}
      user = helper.signup_user(params)
      expect(user.name).to eq(@user.name)
      expect(user.email).to eq("user@gmail.com")
      expect(user.password).to eq(@user.password)
    end
    it "raises an error with invalid parameters" do
      params = {}
      expect { helper.signup_user(params) }.to raise_error(StandardError)
    end
  end

  describe "#login_user" do
    it "returns the user with valid credentials" do
      params = { email: @user.email, password: @user.password }
      result = helper.login_user(params)
      expect(result).to eq(@user)
    end

    it "raises an error for an account that doesn't exist" do
      params = { email: "nonexistent@example.com", password: "password123" }
      expect { helper.login_user(params) }.nil?
    end

    it "raises an error for invalid credentials" do
      params = { email: @user.email, password: "wrong_password" }
      expect {  helper.login_user(params) }.nil?
    end
  end
end
