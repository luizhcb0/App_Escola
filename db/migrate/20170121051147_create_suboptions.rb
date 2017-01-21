class CreateSuboptions < ActiveRecord::Migration[5.0]
  def change
    create_table :suboptions do |t|
      t.string :name
      t.belongs_to :option, null: true, index: true
    end
    add_foreign_key :suboptions, :options, on_delete: :cascade
  end
end
