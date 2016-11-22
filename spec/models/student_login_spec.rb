require 'rails_helper'

RSpec.describe StudentLogin, type: :model do
  describe "Associations" do
    it { should belong_to(:login) }
    it { should belong_to(:student) }
  end
end
