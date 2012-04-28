class CreateAssociatedTags < ActiveRecord::Migration
  def up
    create_table :associated_tags do |t|
      t.references :track
      t.references :artist
      t.references :tag
      t.integer :count

      t.timestamps
    end
    add_index :associated_tags, :track_id
    add_index :associated_tags, :artist_id

    remove_column :tags, :track_id
    remove_column :tags, :artist_id
    remove_column :tags, :count
  end

  def down

    remove_index :associated_tags, :track_id
    remove_index :associated_tags, :artist_id

    drop_table :associated_tags

    add_column :tags, :track_id, :integer
    add_column :tags, :artist_id, :integer
    add_column :tags, :count, :integer
  end
end
