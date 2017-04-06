require 'rails_helper'

RSpec.describe MessageStudentsController, type: :controller do

  describe "POST read for a specific message_student" do

    it "should save the message_student as read" do
      msg = create(:message)
      msg_std = msg.message_students.first
      expect(msg_std.read).to eq false
      post :read, params: {message_id: msg_std.message_id, student_id: msg_std.student_id}
      # post :read, params: {id: msg_std.id}
      expect(msg_std.reload.read).to eq true
    end
  end

end
