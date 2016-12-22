class ProfessorsController < ApplicationController
  include StrongParamsHolder

  def index
    @professors = Professor.all
  end

  def show
    @professor = Professor.find(params[:id])
  end

  def new
    @professor = Professor.new()
  end

  def create
    @professor = Professor.new(user: User.new(user_params).with_role("professor"))
    if @professor.user.save && @professor.save
      redirect_to professors_path
    else
      render :new
    end
  end

  def edit
    @professor = Professor.find(params[:id])
  end

  def update
    @professor = Professor.find(params[:id])
    if @professor.user.update_attributes(user_params)
      redirect_to professors_path(@professor.id)
    else
      render :edit
    end
  end

  def destroy
    @professor = Professor.find(params[:id])
    @professor.destroy
    redirect_to professors_path
  end

  def send_message
    @message = Message.new()
  end

  def save_message
    @message = Message.new(message_params)
    if @message.save
      redirect_to professors_path
    else
      render :send_message
    end
  end
end
