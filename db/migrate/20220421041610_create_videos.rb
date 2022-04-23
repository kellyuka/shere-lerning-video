class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.references :list, null: false, foreign_key: true
      t.string :videoid

      t.timestamps
    end
  end
end
