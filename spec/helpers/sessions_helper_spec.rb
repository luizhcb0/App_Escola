require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do

  describe "#log_in(user)" do
    it "should set session with user.id" do
      user = build(:user, id: 1)
      log_in(user)
      expect(session[:user_id]).to eq user.id
    end
  end

  describe "#log_out" do
    it "should clear session" do
      session[:user_id] = 1
      expect(session[:user_id]).to eq 1
      log_out
      expect(session[:user_id]).to eq nil
    end

    it "should clear current_user" do
      @current_user = build(:user, id: 1)
      expect(@current_user).to_not eq nil
      log_out
      expect(@current_user).to eq nil
    end
  end

  describe "#current_user" do
    it "should return nil if the session id is empty" do
      expect(current_user).to eq nil
    end

    it "should return the user which the session login_id is set" do
      user_array = 2.times.map { create(:user) }
      user = user_array[rand 2]
      session[:user_id] = user.id
      expect(current_user).to eq user
    end
  end

  describe "#logged_in?" do
    it "should return if a login have been added to current user" do
      expect(logged_in?).to eq false
      session[:user_id] = create(:user).id
      expect(logged_in?).to eq true
    end
  end

end
