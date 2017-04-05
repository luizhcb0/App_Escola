require 'rails_helper'

RSpec.describe MessageConnection, type: :model do
  describe "Associations" do
    it { should belong_to(:classroom) }
    it { should belong_to(:student) }
    it { should belong_to(:message) }
  end
end
