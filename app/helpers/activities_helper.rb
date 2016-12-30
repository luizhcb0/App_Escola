module ActivitiesHelper
  def category_array
    category_array = Activity_Category.all.map { |category| [category.name, category.id] }
  end

  def classroom_array
    classroom_array = Classroom.all.map { |classroom| [classroom.name, classroom.id] }
  end
end
