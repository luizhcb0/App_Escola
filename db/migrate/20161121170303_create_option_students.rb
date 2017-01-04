class CreateOptionStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :option_students do |t|
      t.belongs_to :student, null: false, index: true
      t.belongs_to :option, null: false, index: true
      t.text :note, null: true
      t.timestamps
    end
    add_foreign_key :option_students, :students, on_delete: :cascade
    add_foreign_key :option_students, :options, on_delete: :cascade
  end
end
