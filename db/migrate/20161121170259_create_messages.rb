class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.belongs_to :classroom, null: false, index: true
      t.text :text
      t.timestamps
    end
    add_foreign_key :messages, :classrooms, on_delete: :cascade
  end
end
