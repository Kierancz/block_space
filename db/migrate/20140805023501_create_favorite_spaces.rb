class CreateFavoriteSpaces < ActiveRecord::Migration
  def change
    create_table :favorite_spaces do |t|
      t.string :space_id
      t.string :integer
      t.integer :user_id

      t.timestamps
    end
  end
end
