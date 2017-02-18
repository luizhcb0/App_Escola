module ReportsHelper
  def student_array
    student_array = Student.all.map { |student| [student.name, student.id] }
  end
end
