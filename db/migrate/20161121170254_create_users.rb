class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      # t.string :username, null: false
      t.string :name, null: false
      t.string :phone
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :role, null: false
    end
  end
end
