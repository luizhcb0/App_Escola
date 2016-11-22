require 'rails_helper'

RSpec.describe School, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should belong_to(:professor) }
  end
end
