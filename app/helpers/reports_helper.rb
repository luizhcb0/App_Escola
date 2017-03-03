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

  # Creates a join between the report suboptions and options, activities and
  # activities_categories, filtring the columns to keep only names and ids.
  def suboptions_with_joins(report_id)
    Report.connection.select_all("select suboption_id, suboptions.name as suboption_name,
    option_id, options.name as option_name, activity_id, activities.name as activity_name,
    activity_category_id from
      (select suboption_id from reports_suboptions where report_id=#{report_id}) as rep_subs
      join suboptions on rep_subs.suboption_id=suboptions.id
      join options on suboptions.option_id=options.id
      join activities on options.activity_id=activities.id
      order by activity_id, option_id, suboption_id")
  end

  # Puts all the note texts of that activity into a string
  # *** It marks the notes that had been used!!
  def mark_notes_for(activity_id, notes_ary)
    text = ""
    notes_ary.each do |note|
      if (note.activity_id == activity_id)
        text += (text.empty?) ? note.text : "<br>"+note.text
        note.activity_id = -1
      end
    end
    return text
  end

end
