class CreateJoinTableMessageStudent < ActiveRecord::Migration[5.0]
  def change
    create_join_table :messages, :students do |t|
      # t.index [:message_id, :student_id]
      # t.index [:student_id, :message_id]
    end
  end
end
