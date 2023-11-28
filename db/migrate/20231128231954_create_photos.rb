class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.integer :creator_id
      t.string :description
      t.string :image
      t.string :title
      t.integer :album_id

      t.timestamps
    end
  end
end
