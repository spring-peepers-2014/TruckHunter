class Truck < ActiveRecord::Base

	has_many :tweets

	validates :name, presence: true
	validates :twitter_handle, uniqueness: true

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?

	before_save :geocode

	before_save do
		self.name.downcase!
	end

end
