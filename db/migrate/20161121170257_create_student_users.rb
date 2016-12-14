class CreateStudentUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :student_users do |t|
      t.belongs_to :student, null: false, index: true
      t.belongs_to :user, null: false, index: true
    end
  end
end
