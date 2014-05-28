require 'spec_helper'

describe ApplicationController do


  describe "current_user" do

    it "returns nil if a user is not logged in" do
      expect(controller.current_user).to be_nil
      expect(controller.logged_in?).to eq false
    end

    it "returns the user if user is logged in" do

      current_user = create_user
      controller.log_user_in(current_user)
      expect(controller.current_user).to eq current_user
      expect(controller.logged_in?).to eq true
    end

    it "can log a user out" do
      current_user = create_user
      controller.log_user_in(current_user)
      controller.log_user_out
      expect(controller.current_user).to eq nil
    end
  end
end
