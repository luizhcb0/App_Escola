class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.belongs_to :user, null: false, index: true
    end
    add_foreign_key :schools, :users, on_delete: :nullify
  end
end
