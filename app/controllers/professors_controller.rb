class ProfessorsController < ApplicationController

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
  end

  def edit
    @professor = Professor.find(params[:id])
  end

  def update
  end

  def destroy
    redirect_to schools_path
  end
end
