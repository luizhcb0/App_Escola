class CreateJoinTableClassroomProfessor < ActiveRecord::Migration[5.0]
  def change
    create_join_table :classrooms, :professors do |t|
      # t.index [:classroom_id, :professor_id]
      # t.index [:professor_id, :classroom_id]
    end
  end
end
