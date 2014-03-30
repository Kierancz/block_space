class Block < ActiveRecord::Base
	belongs_to :story
	belongs_to :user
	validates :story_id, presence: true
end
