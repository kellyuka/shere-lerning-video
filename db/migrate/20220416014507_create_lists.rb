class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.string :title
      t.string :playlistid
      t.text :recommend
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
