class CreateClips < ActiveRecord::Migration[5.0]
  def change
    create_table :clips do |t|
      t.attachment :media
      t.timestamps
    end
  end
end
