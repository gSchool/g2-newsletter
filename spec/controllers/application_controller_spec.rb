require 'spec_helper'

describe ApplicationController do


  describe "current_user" do

    it "returns nil if a user is not logged in" do
      expect(controller.current_user).to be_nil
    end

    it "returns the user if user is logged in" do
    current_user = create_user

      controller.log_user_in(current_user.id)
      expect(controller.current_user).to eq current_user
    end

    it "can log a user in" do

      user = create_user
      controller.log_user_in(user.id)
      expect(session[:user_id]).to eq user.id
    end

    it "can log a user out" do

      user = create_user
      controller.log_user_in(user.id)
      expect(session[:user_id]).to eq user.id
      controller.log_user_out
      expect(session[:user_id]).to eq nil
    end
  end
end
