class Post < ApplicationRecord
	include Votable 
	
	validates :title, presence: true 
	validates :subs, presence: { message: 'must have at least one sub' }

	belongs_to :author, 
		foreign_key: :user_id, 
		class_name: :User, 
		inverse_of: :posts

	has_many :post_subs, inverse_of: :post
	has_many :subs, through: :post_subs, source: :sub
	has_many :comments, inverse_of: :post

	def comments_by_parent 
		comments_by_parent = Hash.new { |h, k| h[k] = [] } 
		self.comments.includes(:author).each do |comment|
			comments_by_parent[comment.parent_comment_id] << comment
		end
		comments_by_parent
	end
end
