class Story < ActiveRecord::Base
	has_many :blocks, dependent: :destroy
	has_and_belongs_to_many :users, -> { uniq }

	attr_accessor :updated_at
end
