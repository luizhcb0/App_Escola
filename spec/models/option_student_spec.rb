require 'rails_helper'

RSpec.describe OptionStudent, type: :model do
  describe "Associations" do
    it { should belong_to(:option) }
    it { should belong_to(:student) }
  end
end
