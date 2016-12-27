class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.belongs_to :professor, null: false, index: true
    end
    add_foreign_key :schools, :professors, on_delete: :cascade
  end
end
