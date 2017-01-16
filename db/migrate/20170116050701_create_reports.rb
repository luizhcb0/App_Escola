class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.belongs_to :student, null: false, index: true

      t.timestamps
    end
    add_foreign_key :reports, :students, on_delete: :cascade
  end
end
