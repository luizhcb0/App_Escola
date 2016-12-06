class CreateLogins < ActiveRecord::Migration[5.0]
  def change
    create_table :logins do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.integer :role, null: false
    end
  end
end
