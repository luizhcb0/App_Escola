class CreateMessageConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :message_connections do |t|
      t.belongs_to :classroom, null: false, index: true
      t.belongs_to :student, null: false, index: true
      t.belongs_to :message, null: false, index: true
    end
    add_foreign_key :message_connections, :classrooms, on_delete: :cascade
    add_foreign_key :message_connections, :students, on_delete: :cascade
    add_foreign_key :message_connections, :messages, on_delete: :cascade
  end
end
