class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :name
      t.belongs_to :activity, null: false, index: true
    end
  end
end
