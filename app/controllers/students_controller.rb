class StudentsController < ApplicationController
  include StrongParamsHolder

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new()
  end

  def create
    @student = Student.new(student_params)
    @student.build_person(person_params)
    if @student.save
      redirect_to students_path
    else
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(student_params) &&
      @student.person.update_attributes(person_params)
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
end
