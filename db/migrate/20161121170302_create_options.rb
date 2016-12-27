class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :name
      t.belongs_to :activity, null: false, index: true
    end
    add_foreign_key :options, :activities, on_delete: :cascade
  end
end
