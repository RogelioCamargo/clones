class User < ApplicationRecord
	validates :username, :session_token, presence: true, uniqueness: true
	validates :password_digest, presence: { message: 'Password can\'t be blank' }
	validates :password, length: { minimum: 4, allow_nil: true } 

	after_initialize :ensure_session_token 

	attr_reader :password 

	def self.generate_session_token
		session_token = SecureRandom.url_safe64(16)
		while User.exists?(session_token: session_token)
			session_token = SecureRandom.url_safe64(16)
		end

		session_token
	end

	def self.find_by_credentials(username, password)
		user = User.find_by(username: username)
		user.is_password?(password)
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
		session_token ||= User.generate_session_token
	end	
end
