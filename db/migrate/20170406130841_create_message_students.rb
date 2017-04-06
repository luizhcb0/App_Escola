class CreateMessageStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :message_students do |t|
      t.belongs_to :message, null: false, index: true
      t.belongs_to :student, null: false, index: true
      t.boolean :read
    end
    add_foreign_key :message_students, :messages, on_delete: :cascade
    add_foreign_key :message_students, :students, on_delete: :cascade
    add_index :message_students, ["message_id", "student_id"], :unique => true
  end
end
