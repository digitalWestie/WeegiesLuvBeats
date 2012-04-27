class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :album
      t.string :genre
      t.string :playlist
      t.string :server_location
      t.integer :plays
      t.integer :mood
      t.string :record_label
      t.integer :texture
      t.string :duration
      t.references :artist

      t.timestamps
    end
    add_index :tracks, :artist_id
  end
end
