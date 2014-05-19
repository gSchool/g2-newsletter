require 'spec_helper'

describe User do
  describe "Validations" do

    it 'should not be valid without an email' do
      @user = User.new email: "", password: 'password', password_confirmation: 'password'
      expect(@user).to_not be_valid
      expect(@user).to have(2).error_on(:email)
    end

    it "should not be valid without a password" do
      @user = User.new email: "whatever@gmail.com", password: '', password_confirmation: ''
      expect(@user).to_not be_valid
      expect(@user).to have(1).error_on(:password)
    end

    it "should be not be valid with a short password" do
      @user = User.new email: "whatever@gmail.com", password: 'short', password_confirmation: 'short'
      expect(@user).to have(1).error_on(:password)

    end

    it "should not be valid with a confirmation mismatch" do
      user = User.new email: "whatever", password: 'shortshort', password_confirmation: 'longlong'
      user.should_not be_valid
    end
  end
end


