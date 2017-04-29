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

  def send_all
    classroom = Classroom.find(params[:classroom_id])
    Report.transaction do
      success = classroom.students.map do |std|
        (report = Report.find_by_student_date(std.id)) ?
          report.update_attributes(draft: false) : true
      end

      if !success.all?
        flash[:error] = "Houve um erro ao enviar os relatorios"
        raise ActiveRecord::Rollback
      else
        flash[:success] = "Relatórios enviados com sucesso"
      end
    end if !classroom.nil?

    redirect_to new_report_path
  end

  def new
    @report = Report.new
    Activity.all.each do |activity|
      @report.report_notes.build
    end
  end

  def create
    @reports = Array.new
    if !params[:student_ids].nil?
      params[:student_ids].each do |student_id|
        std_report = Report.find_by_student_date(student_id)
        if (std_report.nil?)
          @reports << Report.new(report_params(student_id))
        else
          new_report = Report.new(report_params(student_id))
          std_report.suboptions << new_report.suboptions
          std_report.report_notes << new_report.report_notes
          @reports << std_report
        end
      end
    end
    Report.transaction do
      success = @reports.map(&:save)
      #success = @reports.map(&:save!) --> Force Model validation
      if @reports.empty?
        flash[:error] = "Pelo menos um aluno deve ser selecionado"
      elsif !success.all?
        errored = @reports.select {|b| !b.errors.blank? }
        # do something with the errored values
        flash[:error] = "Rascunho não pôde ser salvo"
        raise ActiveRecord::Rollback
      else
        flash[:success] = "Rascunho salvo com sucesso"
      end
    end
    redirect_to new_report_path
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

  def set_presence
    @student = Student.find(params[:id])
    @student.update_attributes(absence: params[:status])
    redirect_to new_report_path
  end


  # Based on params :student_id and :date, finds the correspondent report
  private
  def find_report_from_params
    Report.find_by_student_date(params[:student_id], params[:date])
  end
end
