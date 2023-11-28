class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :photo_id
      t.integer :commenter_id
      t.string :text

      t.timestamps
    end
  end
end
