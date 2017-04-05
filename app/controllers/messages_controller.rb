class MessagesController < ApplicationController
  include StrongParamsHolder
  include SessionsHelper

  def index
    if current_user
      if current_user.role.name == 'professor'
        @messages = Message.where(classroom_id: current_user.classroom.id).order(params[:sort])

      elsif current_user.role.name == 'student'
        @messages = Message.includes(:students).where(
          students: {id: current_user.students.ids}).order(params[:sort])

      elsif current_user.role.name == 'admin'
        @messages = Message.all
      end

    else
      redirect_to new_session_path
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new()
  end

  def create
    @message = Message.new(message_params)
    params[:message_connection][:student_ids].each do |std|
      @message.message_connections.build(classroom_id: params[:message_connection][:classroom_id], student_id: std) if std.present?
    end
    if @message.save
      redirect_to messages_path
    else
      render :new
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(message_params)
      redirect_to messages_path(@message.id)
    else
      render :edit
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to messages_path
  end

end
