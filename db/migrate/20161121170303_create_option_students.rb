class CreateOptionStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :option_students do |t|
      t.belongs_to :student, null: false, index: true
      t.belongs_to :option, null: false, index: true
      t.timestamps
    end
  end
end
