class CreateReportNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :report_notes do |t|
      t.belongs_to :activity, null: false, index: true
      t.belongs_to :report, null: false, index: true
      t.text :text
    end
    add_foreign_key :report_notes, :activities, on_delete: :cascade
    add_foreign_key :report_notes, :reports, on_delete: :cascade
  end
end
