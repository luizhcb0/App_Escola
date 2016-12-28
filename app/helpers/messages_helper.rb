module MessagesHelper

  def students_array
    students_array = Student.all.map { |student| [student.name, student.id] }
  end
end
