class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :sender_receiver, null: false
      t.timestamps
    end
  end
end
