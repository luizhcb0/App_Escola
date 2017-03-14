class ReportsController < ApplicationController
  include StrongParamsHolder

  def index
    student = Student.find(params[:student_id])
    @reports = student.reports
  end

  def show
    @report = find_report_from_params
  end

  def search
    redirect_to student_report_path(params[:student_id],params[:date])
  end

  def new
    @report = Report.new
  end

  def create
    @reports = Array.new
    params[:student_ids].each do |student_id|
      @reports << @report = Report.new(report_params(student_id))
    end
    Report.transaction do
      success = @reports.map(&:save)
      unless success.all?
        errored = @reports.select {|b| !b.errors.blank? }
        # do something with the errored values
        render :new
        raise ActiveRecord::Rollback
      else
        redirect_to root_path
      end
    end
    # Report.transaction do
    #   @reports.each(&:save!)
    # end
  end

  def edit
    @categories = ActivityCategory.all
    @activities = Activity.all
    @options = Option.all
    @suboptions = Suboption.all
    @report = find_report_from_params
  end

  def update
    @report = find_report_from_params
    if @report.update_attributes(report_params)
      redirect_to student_report_path(@report.student, @report.date)
    else
      render :edit
    end
  end

  def destroy
    @report = find_report_from_params
    @report.destroy if !@report.nil?
    redirect_to root_path
  end

  # Based on params :student_id and :date, finds the correspondent report
  private
  def find_report_from_params
    Report.where(student_id: params[:student_id], date: params[:date]).first
  end

end
