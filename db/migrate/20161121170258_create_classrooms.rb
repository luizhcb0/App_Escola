class CreateClassrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :classrooms do |t|
      t.belongs_to :user, null: false, index: true
      t.string :shift
    end
    add_foreign_key :classrooms, :users, on_delete: :nullify
  end
end
