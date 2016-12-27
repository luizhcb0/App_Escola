class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.belongs_to :professor, null: false, index: true
      t.string :text
      t.timestamps :date
    end
    add_foreign_key :messages, :professors, on_delete: :cascade
  end
end
