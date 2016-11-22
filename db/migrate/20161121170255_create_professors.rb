class CreateProfessors < ActiveRecord::Migration[5.0]
  def change
    create_table :professors do |t|
      t.belongs_to :person, null: false, index: true
      t.belongs_to :login, null: false, index: true
    end
  end
end
