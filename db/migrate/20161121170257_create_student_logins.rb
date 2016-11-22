class CreateStudentLogins < ActiveRecord::Migration[5.0]
  def change
    create_table :student_logins do |t|
      t.belongs_to :student, null: false, index: true
      t.belongs_to :login, null: false, index: true
    end
  end
end
