require 'spec_helper'

describe User do
  describe "Validations" do

    it 'should not be valid without an email' do
      @user = User.new email: "", password: 'password', password_confirmation: 'password'
      expect(@user).to_not be_valid
      expect(@user).to have(2).error_on(:email)
    end
    it 'should be valid with a valid email address' do
      user = User.new email: "whatever@gmail.com", password: 'password', password_confirmation: 'password'
      user.should be_valid
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
      @user = User.new email: "whatever", password: 'shortshort', password_confirmation: 'longlong'
      expect(@user).to have(1).error_on(:password_confirmation)
    end
    it "should be valid with a password of 8 characters " do
      user = User.new email: "email@example.com", password: 'shortshort', password_confirmation: 'shortshort'
      user.should be_valid
    end
    it "should not be valid with a duplicate email" do
      User.create email: "email@example.com", password: 'shortshort', password_confirmation: 'shortshort'
      @user2 = User.new email: "email@example.com", password: 'shortshort', password_confirmation: 'shortshort'
     expect(@user2).to have(1).error_on(:email)
    end
  end
end


