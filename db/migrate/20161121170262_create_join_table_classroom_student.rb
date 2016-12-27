class CreateJoinTableClassroomStudent < ActiveRecord::Migration[5.0]
  def change
    create_join_table :classrooms, :students do |t|
      # t.index [:classroom_id, :student_id]
      # t.index [:student_id, :classroom_id]
    end
    add_foreign_key :classrooms_students, :classrooms, on_delete: :cascade
    add_foreign_key :classrooms_students, :students, on_delete: :cascade
  end
end
