class User < ApplicationRecord
	validates :username, :session_token, presence: true, uniqueness: true
	validates :password_digest, presence: { message: 'Password can\'t be blank' }
	validates :password, length: { minimum: 4, allow_nil: true } 

	after_initialize :ensure_session_token 

	attr_reader :password 

	has_many :subs, 
		primary_key: :id, 
		foreign_key: :moderator_id, 
		class_name: :Sub,
		inverse_of: :moderator

	has_many :posts, inverse_of: :author
	has_many :comments, inverse_of: :user 

	def self.generate_session_token
		begin   
			session_token = SecureRandom::urlsafe_base64(16)
		end while User.exists?(session_token: session_token)

		session_token
	end

	def self.find_by_credentials(username, password)
		user = User.find_by(username: username)
		user.is_password?(password) ? user : nil
	end

	def is_password?(password)
		BCrypt::Password.new(self.password_digest).is_password?(password)
	end

	def password=(password)
		@password = password 
		self.password_digest = BCrypt::Password.create(password)
	end

	def reset_session_token!
		self.session_token = User.generate_session_token 
		self.save! 
		self.session_token 
	end

	private 

	def ensure_session_token 
		self.session_token ||= User.generate_session_token
	end	
end
