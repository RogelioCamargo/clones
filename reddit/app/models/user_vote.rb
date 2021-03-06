class UserVote < ApplicationRecord
	validates :user_id, uniqueness: { scope: %i(votable_id votable_type) }

	belongs_to :user, inverse_of: :user_votes 
	belongs_to :votable, polymorphic: true
end
