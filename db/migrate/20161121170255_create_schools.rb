class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name, null: false
      t.belongs_to :user, null: false, index: true
      # Image Logo goes here 
    end
    add_foreign_key :schools, :users, on_delete: :restrict
  end
end
