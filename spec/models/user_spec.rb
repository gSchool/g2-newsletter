require 'spec_helper'

describe User do
  describe "Validations" do

    let(:user) {create_user }
    let(:user2) {new_user(email: 'whatever@gmail.com') }

    it 'can create a new user' do
      expect(user).to be_valid
    end
    it 'can create an admin user' do
      user.admin = true
      expect(user).to be_valid
    end
    it 'should not be valid without an email' do
      user.email = nil
      expect(user).to_not be_valid
      expect(user).to have(2).errors_on(:email)
    end

    it "should not be valid without a password" do
      user.password = nil
      user.password_confirmation = nil
      expect(user).to_not be_valid
      expect(user).to have(1).error_on(:password)
    end

    it "should be not be valid with a short password" do
      user.password = 'short'
      user.password_confirmation = 'short'
      expect(user).to have(1).error_on(:password)

    end

    it "should not be valid with a confirmation mismatch" do
      user.password = 'longlong'
      user.password_confirmation = 'shortshort'
      expect(user).to have(1).error_on(:password_confirmation)
    end
    it "should be valid with a password of 8 characters " do
      user.password = '88888888'
      user.password_confirmation = '88888888'
      expect(user).to have(0).error_on(:password)

      expect(user).to be_valid
    end
    it "should not be valid with a duplicate email" do
      user.update_attributes(email: 'whatever@gmail.com')
      expect(user2).to have(1).error_on(:email)
    end
  end
end


