class TruckPresenter

	def self.truck_pins
		trucks = ActiveTrucksManager.trucks_to_pin
		encode_geo_json(trucks)	
	end

	def self.encode_geo_json(trucks)
		locations = []

		Jbuilder.encode do |json|
			json.array! trucks do |truck|

				truck_location = [truck.latitude, truck.longitude]
				while locations.include?(truck_location)
					offset_coords(truck_location)
				end
				locations << truck_location

				json.type "Feature"
				json.geometry do
					json.type "Point"
					json.coordinates [truck_location[1], truck_location[0]]
				end

				json.properties do
					json.title truck.name
					json.description  "<img src='#{truck.profile_img_url}' /><br><a href='http://twitter.com/#{truck.twitter_handle}' target='_blank'>@"+truck.twitter_handle+"</a>
					<br><i>"+truck.tweets.last.body+"</i><br>Tweeted on "+(truck.tweets.last.tweet_time).in_time_zone.strftime("%b %e, %l:%M %p")
					
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

	def self.offset_coords(location)
		location[0] += [0.0003, 0.0006, -0.0003, -0.0006, 0.0005, -0.0005, 0.0004, -0.0004].shuffle.sample
		location[1] += [0.0003, 0.0006, -0.0003, -0.0006, 0.0005, -0.0005, 0.0004, -0.0004].shuffle.sample
		return location
	end

end