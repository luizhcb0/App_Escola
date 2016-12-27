require 'rails_helper'

RSpec.describe StudentUser, type: :model do
  describe "Associations" do
    it { should belong_to(:user).dependent(:delete) }
    it { should belong_to(:student) }
  end
end
