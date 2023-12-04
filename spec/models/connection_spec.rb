require 'rails_helper'

RSpec.describe Connection, type: :model do

  describe "associations" do
    it {should belong_to(:followers).class_name(User)}
    it {should belong_to(:following).class_name(User)}
  end
end