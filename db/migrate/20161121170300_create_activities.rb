class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.belongs_to :activity_category, null: false, index: true
    end
    add_foreign_key :activities, :activity_categories, on_delete: :cascade
  end
end
