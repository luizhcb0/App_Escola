class CreateReportOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :report_options do |t|
      t.belongs_to :report, null: false, index: true
      t.belongs_to :option, null: false, index: true
      t.text :note, null: true
      t.timestamps
    end
    add_foreign_key :report_options, :reports, on_delete: :cascade
    add_foreign_key :report_options, :options, on_delete: :cascade
  end
end
