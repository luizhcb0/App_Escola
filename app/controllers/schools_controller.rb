class SchoolsController < ApplicationController
  include StrongParamsHolder

  def index
    @schools = School.all
  end

  def show
    @school = School.find(params[:id])
  end

  def new
    @school = School.new()
  end

  def create
    @principal = Professor.new(person: Person.new(person_params),
      login: Login.new(login_params))
    @school = School.new(school_params)
    @school.professor = @principal
    if @school.save
      redirect_to schools_path
    else
      render :new
    end
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    if @school.update_attributes(school_params) &&
      @school.professor.login.update_attributes(login_params) &&
      @school.professor.person.update_attributes(person_params)
      redirect_to schools_path(@school.id)
    else
      render :edit
    end
  end

  def destroy
    @school = School.find(params[:id])
    @school.destroy
    redirect_to schools_path
  end
end