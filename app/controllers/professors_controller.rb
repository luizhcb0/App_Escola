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
    @professor = Professor.new(person: Person.new(person_params),
      login: Login.new(login_params))
    if @professor.save
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
    if @professor.login.update_attributes(login_params) &&
      @professor.person.update_attributes(person_params)
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
end
