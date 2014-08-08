class FixFavoritesTable < ActiveRecord::Migration
  def change
  	change_column :favorite_spaces, :space_id, 'integer USING CAST(favorite_spaces AS integer)'
  	remove_column :favorite_spaces, :integer
  end
end
