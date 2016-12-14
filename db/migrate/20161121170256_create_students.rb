class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      # t.belongs_to :person, null: false, index: true
      # t.string :father_name
      # t.string :mother_name
      t.string :name, null: false
      t.string :address
      t.date :birthday
    end
  end
end
