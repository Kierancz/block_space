class FixFavoritesTable < ActiveRecord::Migration
  def change
  	change_column :favorite_spaces, :space_id, 'integer USING CAST(column_name AS integer)'
  	remove_column :favorite_spaces, :integer
  end
end
