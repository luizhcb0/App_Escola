class ActivityCategoriesController < ApplicationController
  include StrongParamsHolder

  def index
    @activity_categories = ActivityCategory.all
  end

  def show
    @activity_category = ActivityCategory.find(params[:id])
  end

  def new
    @activity_category = ActivityCategory.new()
  end

  def create
    @activity_category = ActivityCategory.new(activity_category_params)
    if @activity_category.save
      redirect_to activity_categories_path
    else
      render :new
    end
  end

  def edit
    @activity_category = ActivityCategory.find(params[:id])
  end

  def update
    @activity_category = ActivityCategory.find(params[:id])
    if @activity_category.update_attributes(activity_category_params)
      redirect_to activity_categories_path(@activity_category.id)
    else
      render :edit
    end
  end

  def destroy
    @activity_category = ActivityCategory.find(params[:id])
    @activity_category.destroy
    redirect_to activity_categories_path

  end

end
