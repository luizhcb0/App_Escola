class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :reports, :suboptions do |t|
      # t.index [:suboption_id, :report_id]
      # t.index [:report_id, :suboption_id]
    end
    add_foreign_key :reports_suboptions, :suboptions, on_delete: :cascade
    add_foreign_key :reports_suboptions, :reports, on_delete: :cascade
  end
end
