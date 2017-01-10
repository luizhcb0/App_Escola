class OptionsController < ApplicationController
  include StrongParamsHolder

  def index
    @options = Option.where(option_id: nil)
  end

  def show
    @option = Option.find(params[:id])
  end

  def new
    @option = Option.new()
    #1.times { @option.suboptions.build}
  end

  def create
    @option = Option.new(option_params)
    if @option.save
      redirect_to options_path
    else
      render :new
    end
  end

  def edit
    @option = Option.find(params[:id])
  end

  def update
    @option = Option.find(params[:id])
    if @option.update_attributes(option_params)
      redirect_to options_path(@option.id)
    else
      render :edit
    end
  end

  def destroy
    @option = Option.find(params[:id])
    @option.destroy
    redirect_to options_path
  end

end
