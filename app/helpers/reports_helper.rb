module ReportsHelper
  def student_array
    student_array = Student.all.map { |student| [student.name, student.id] }
  end

  def students
    students = Student.all
  end

  def categories
    categories = ActivityCategory.all
  end

  def activities
    activities = Activity.all
  end

  def options
    options = Option.all
  end

  def suboptions
    suboptions = Suboption.all
  end

end
