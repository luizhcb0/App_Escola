class ClassroomsController < ApplicationController
  include StrongParamsHolder

  def index
    @classrooms = Classroom.all
  end

  def show
    @classroom = Classroom.find(params[:id])
    @students = Student.find(@classroom.student_ids)
    @activities = Activity.find(@classroom.activity_ids)
  end

  def new
    @classroom = Classroom.new()
  end

  def create
    @classroom = Classroom.new(classroom_params)
    @classroom.build_user(user_params).with_role("professor")
    if @classroom.user.save && @classroom.save
      redirect_to classrooms_path
    else
      render :new
    end
  end

  def edit
    @professors = Professor.all
    @students = Student.all
    @activities = Activity.all
    @classroom = Classroom.find(params[:id])
  end

  def update
    @classroom = Classroom.find(params[:id])
    if @classroom.user.update_attributes(user_params) &&
      @classroom.update_attributes(classroom_params)
      redirect_to classrooms_path(@classroom.id)
    else
      render :edit
    end
  end

  def destroy
    @classroom = Classroom.find(params[:id])
    @classroom.destroy
    redirect_to classrooms_path
  end
end
