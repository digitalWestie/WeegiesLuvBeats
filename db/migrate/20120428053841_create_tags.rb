class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :count
      t.string :url
      t.references :artist
      t.references :track

      t.timestamps
    end
    add_index :tags, :artist_id
    add_index :tags, :track_id
  end
end
