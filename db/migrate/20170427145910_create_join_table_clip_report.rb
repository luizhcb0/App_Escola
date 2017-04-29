class CreateJoinTableClipReport < ActiveRecord::Migration[5.0]
  def change
    create_join_table :clips, :reports do |t|
      # t.index [:clip_id, :report_id]
      # t.index [:report_id, :clip_id]
    end
    add_foreign_key :clips_reports, :clips, on_delete: :cascade
    add_foreign_key :clips_reports, :reports, on_delete: :cascade
  end
end
