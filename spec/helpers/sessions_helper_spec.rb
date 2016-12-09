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

  describe "#log_in(login)" do
    it "should set session with login.id" do
      login = build(:login, id: 1)
      log_in(login)
      expect(session[:login_id]).to eq login.id
    end
  end

  describe "#log_out" do
    it "should clear session" do
      session[:login_id] = 1
      expect(session[:login_id]).to eq 1
      log_out
      expect(session[:login_id]).to eq nil
    end

    it "should clear current_user" do
      @current_login = build(:login, id: 1)
      expect(@current_login).to_not eq nil
      log_out
      expect(@current_login).to eq nil
    end
  end

  describe "#current_login" do
    it "should return nil if the session id is empty" do
      expect(current_login).to eq nil
    end

    it "should return the login which the session login_id is set" do
      login_array = 2.times.map { create(:login) }
      login = login_array[rand 2]
      session[:login_id] = login.id
      expect(current_login).to eq login
    end
  end

  describe "#logged_in?" do
    it "should return if a login have been added to current login" do
      expect(logged_in?).to eq false
      session[:login_id] = create(:login).id
      expect(logged_in?).to eq true
    end
  end

end
