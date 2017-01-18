class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :options, :reports do |t|
      # t.index [:option_id, :report_id]
      # t.index [:report_id, :option_id]
    end
    add_foreign_key :options_reports, :options, on_delete: :cascade
    add_foreign_key :options_reports, :reports, on_delete: :cascade
  end
end
