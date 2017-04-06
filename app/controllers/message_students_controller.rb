class MessageStudentsController < ApplicationController

  def read
    msg_std = MessageStudent.where(message_id: params[:message_id],
      student_id: params[:student_id]).first
    # msg_std = MessageStudent.find(params[:id])
    msg_std.update(read: true)
    redirect_to :back
  end

end
