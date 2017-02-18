module ClassroomsHelper
  def professor_array
    professor_array = Professor.all.map { |professor| [professor.user.name, professor.id] }
  end

  def professors
    professors = Professor.all
  end

  def activities
    activities = Activity.all
  end

  def students
    students = Student.all
  end
end
