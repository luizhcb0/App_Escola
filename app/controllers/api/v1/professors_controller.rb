class Api::V1::ProfessorsController < ApplicationController
  include StrongParamsHolder
  
  def index
    render json: Professor.all
  end
  
  def show
    respond_to do |format|
      format.json { render json: Professor.find(params[:id]) }
    end
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
