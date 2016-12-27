class CreateJoinTableActivityClassroom < ActiveRecord::Migration[5.0]
  def change
    create_join_table :activities, :classrooms do |t|
      # t.index [:activity_id, :classroom_id]
      # t.index [:classroom_id, :activity_id]
    end
    add_foreign_key :activities_classrooms, :activities, on_delete: :cascade
    add_foreign_key :activities_classrooms, :classrooms, on_delete: :cascade
  end
end
