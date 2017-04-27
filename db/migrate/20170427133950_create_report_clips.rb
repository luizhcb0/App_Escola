class CreateReportClips < ActiveRecord::Migration[5.0]
  def change
    create_table :report_clips do |t|
      t.belongs_to :report, null: false, index: true
      t.attachment :media

      t.timestamps
    end
    add_foreign_key :report_clips, :reports, on_delete: :cascade
  end
end
