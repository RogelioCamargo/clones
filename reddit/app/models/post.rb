class Post < ApplicationRecord
	validates :title, presence: true 

	belongs_to :author, 
		primary_key: :id, 
		foreign_key: :user_id, 
		class_name: :User, 
		inverse_of: :posts
end
