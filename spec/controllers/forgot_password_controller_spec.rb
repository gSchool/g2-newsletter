require 'spec_helper'

describe ForgotPasswordController do

  describe "User" do
  end

  it "can update password" do
    user = create_user
    password = "barbarbar"
    user.update_attributes(:password => password, :password_confirmation => "barbarbar")
    expect(user.password).to be(password)
  end
end
