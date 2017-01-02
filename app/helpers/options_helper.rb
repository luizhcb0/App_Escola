module OptionsHelper

  def activity_array
    activity_array = Activity.all.map { |activity| [activity.name, activity.id] }
  end
end
