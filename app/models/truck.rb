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

	def self.geo_json
		@trucks = ActiveTrucksManager.trucks_to_pin

		Jbuilder.encode do |json|
			json.array! @trucks do |truck|
				json.type "Feature"
				json.geometry do
					json.type "Point"
					json.coordinates [truck.longitude, truck.latitude]
				end
				json.properties do
					json.title truck.name
					json.description  "<img src='#{truck.profile_img_url}' /><br><a href='http://twitter.com/#{truck.twitter_handle}' target='_blank'>@"+truck.twitter_handle+"</a>
					<br><i>"+truck.tweets.last.body+"</i><br>Tweeted on "+(truck.tweets.last.tweet_time-4.hours).in_time_zone.strftime("%b %e, %l:%M %p")
					
					json.icon do
						json.iconUrl "/assets/foodTruck.png"
						json.iconSize [28, 22]
						json.iconAnchor [25, 25]
						json.popupAnchor [0, -25]
						json.className "dot"
					end
				end
			end
		end

	end

end
