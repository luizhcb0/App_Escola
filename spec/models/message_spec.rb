require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:sender_receiver) }
    it { should validate_presence_of(:classrooms) }
    it { should validate_presence_of(:students) }
  end

  describe "Associations" do
    it { should have_and_belong_to_many(:classrooms) }
    it { should have_many(:message_students) }
    it { should have_many(:students) }
  end
end
