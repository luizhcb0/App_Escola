class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :name
      t.belongs_to :activity, null: false, index: true
      t.belongs_to :option, null: true
    end
    add_foreign_key :options, :activities, on_delete: :cascade
    add_foreign_key :options, :options, on_delete: :cascade
  end
end
