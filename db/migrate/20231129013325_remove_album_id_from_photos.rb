class RemoveAlbumIdFromPhotos < ActiveRecord::Migration[7.0]
  def change
    remove_column :photos, :album_id
  end
end
