class AddHasEntryToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :has_entry, :boolean
  end
end
