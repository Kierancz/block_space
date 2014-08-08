class Space < ActiveRecord::Base
	has_many :blocks, dependent: :destroy
	has_and_belongs_to_many :users, -> { uniq }
	has_many :favorite_spaces
	has_many :favorited_by, through: :favorite_spaces, source: :user
end
