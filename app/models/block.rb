class Block < ActiveRecord::Base
	belongs_to :user
	belongs_to :space
	validates :space_id, presence: true
end
