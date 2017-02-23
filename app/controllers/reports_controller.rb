class ReportsController < ApplicationController
  include StrongParamsHolder

  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
  end

  def search
    @report = Report.where(student_id: params[:student_id],
      created_at: (params[:date].to_date.beginning_of_day..params[:date].to_date.end_of_day)).first
    render :show
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to reports_path
    else
      render :new
    end
  end

  def edit
    @categories = ActivityCategory.all
    @activities = Activity.all
    @options = Option.all
    @suboptions = Suboption.all
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(report_params)
      redirect_to reports_path(@report.id)
    else
      render :edit
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_path
  end
end
