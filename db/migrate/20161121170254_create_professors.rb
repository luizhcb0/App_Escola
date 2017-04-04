class CreateProfessors < ActiveRecord::Migration[5.0]
  def change
    create_table :professors do |t|
      t.belongs_to :classroom, null: true, index: true
      t.string :name
    end
    add_foreign_key :professors, :classrooms, on_delete: :nullify
  end
end
