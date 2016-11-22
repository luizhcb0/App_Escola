require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe "Associations" do
    it { should belong_to(:person) }
    it { should belong_to(:login) }
    it { should have_one(:school) }
    it { should have_many(:messages) }
    it { should have_and_belong_to_many(:classrooms) }
  end
end
