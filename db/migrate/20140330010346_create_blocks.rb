class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :number
      t.text :content
      t.integer :story_id
      t.integer :user_id

      t.timestamps
    end
    add_index :blocks, [:story_id, :user_id]
  end
end
