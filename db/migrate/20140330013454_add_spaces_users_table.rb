class AddSpacesUsersTable < ActiveRecord::Migration
  def change
  	create_table :spaces do |t|
      		t.string :title
      		t.text :description
          t.string :permissions

      		t.timestamps
      	end

      	create_table :users do |t|
      		t.string :username
      		t.string :email

      		t.timestamps
    	end

    	create_table :spaces_users do |t|
    		t.belongs_to :space
    		t.belongs_to :user
    	end
  end
end
