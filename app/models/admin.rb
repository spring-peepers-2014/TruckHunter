class Admin < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true
	validates :password_digest, presence: true

	has_secure_password
end
