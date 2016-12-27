class CreateStudentUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :student_users do |t|
      t.belongs_to :student, null: false, index: true
      t.belongs_to :user, null: false, index: true
    end
    add_foreign_key :student_users, :students, on_delete: :cascade
    add_foreign_key :student_users, :users, on_delete: :cascade
  end
end
