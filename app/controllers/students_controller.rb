class StudentsController < ApplicationController
  include StrongParamsHolder

  def index
    @students = Student.all
    @messages = Message.all
  end

  def show
    @student = Student.find(params[:id])
    @user = @student.users.first
  end

  def new
    @student = Student.new
    @user = User.new
  end

  def create
    @student = Student.new(student_params)
    @student.users.build(user_params).with_role("student")
    if @student.save
      redirect_to students_path
    else
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
    @user = @student.users.first
  end

  def update
    @student = Student.find(params[:id])
    if @student.users.first.update_attributes(user_params) &&
      @student.update_attributes(student_params)
      redirect_to students_path(@student.id)
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_path
  end

  def view
    @messages = Message.all
  end

end
