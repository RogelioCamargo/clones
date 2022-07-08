class Comment < ApplicationRecord
	validates :body, presence: true 
	belongs_to :author, 
		foreign_key: :user_id, 
		class_name: :User, 
		inverse_of: :comments 

	belongs_to :post, 
		inverse_of: :comments

	has_many :child_comments, 
		primary_key: :id,
		foreign_key: :paent_comment_id,
		class_name: :Comment,

	belongs_to :parent_comment, 
		primary_key: :id, 
		foreign_key: :parent_comment_id,
		class_name: :Comment,
		optional: true 

	private 

	def ensure_post_id! 
		self.post_id ||= self.parent_comment.post_id if parent_comment
	end
end