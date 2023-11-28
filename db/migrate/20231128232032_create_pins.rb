class CreatePins < ActiveRecord::Migration[7.0]
  def change
    create_table :pins do |t|
      t.integer :photo_id
      t.integer :pinner_id

      t.timestamps
    end
  end
end
