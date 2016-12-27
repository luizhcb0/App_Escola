class CreateJoinTableClassroomProfessor < ActiveRecord::Migration[5.0]
  def change
    create_join_table :classrooms, :professors do |t|
      # t.index [:classroom_id, :professor_id]
      # t.index [:professor_id, :classroom_id]
    end
    add_foreign_key :classrooms_professors, :classrooms, on_delete: :cascade
    add_foreign_key :classrooms_professors, :professors, on_delete: :cascade
  end
end
