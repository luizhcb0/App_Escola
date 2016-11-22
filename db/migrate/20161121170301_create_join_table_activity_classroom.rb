class CreateJoinTableActivityClassroom < ActiveRecord::Migration[5.0]
  def change
    create_join_table :activities, :classrooms do |t|
      # t.index [:activity_id, :classroom_id]
      # t.index [:classroom_id, :activity_id]
    end
  end
end
