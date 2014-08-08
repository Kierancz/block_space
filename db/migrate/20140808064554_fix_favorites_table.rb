class FixFavoritesTable < ActiveRecord::Migration
  def change
  	remove_column :favorite_spaces, :space_id
  	remove_column :favorite_spaces, :integer
  	add_column :favorite_spaces, :space_id, :integer
  end
end
