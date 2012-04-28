class AddHasEntryToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :has_entry, :boolean
  end
end
