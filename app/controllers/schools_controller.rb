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
    @school = School.new(school_params)
    @school.user = User.new(user_params).with_role("principal")
    if @school.user.save && @school.save
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
    if @school.user.update_attributes(user_params) &&
      @school.update_attributes(school_params)
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
