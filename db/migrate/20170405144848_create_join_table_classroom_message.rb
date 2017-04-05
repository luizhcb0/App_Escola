class CreateJoinTableClassroomMessage < ActiveRecord::Migration[5.0]
  def change
    create_join_table :classrooms, :messages do |t|
      # t.index [:classroom_id, :message_id]
      # t.index [:message_id, :classroom_id]
    end
    add_foreign_key :classrooms_messages, :classrooms, on_delete: :cascade
    add_foreign_key :classrooms_messages, :messages, on_delete: :cascade
    add_index :classrooms_messages, ["classroom_id", "message_id"], :unique => true
  end
end
