class Post < ApplicationRecord
	validates :title, presence: true 

	belongs_to :author, 
		foreign_key: :user_id, 
		class_name: :User, 
		inverse_of: :posts

	has_many :post_subs, inverse_of: :post
	has_many :subs, through: :post_subs, source: :sub
end
