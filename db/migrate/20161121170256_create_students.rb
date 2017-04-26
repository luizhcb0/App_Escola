class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.string :address
      t.date :birthday
      t.attachment :avatar
    end
  end
end
