class Space < ActiveRecord::Base
	has_many :blocks, dependent: :destroy
	has_and_belongs_to_many :users, -> { uniq }
	has_many :favorite_spaces
	has_many :favorited_by, through: :favorite_spaces, source: :user

	scope :desc, order("spaces.updated_at DESC")
	#scope :fav, Space.joins(:favorite_spaces).select('spaces.*, count(space_id) as "favorite_space_count"').group(:space_id).order("favorite_space_count ASC")
	scope :fav,
		select("spaces.*, count(favorite_spaces.id) AS favorite_space_count").
		joins(:favorite_spaces).
		group("spaces.id").
		order("favorite_space_count DESC")
end
