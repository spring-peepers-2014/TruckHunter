class ActiveTrucksManager

	def has_current_location?(truck)
		return false if truck.latitude.nil? || truck.longitude.nil?
		(Time.now - truck.location_last_updated) < 14400 ###4 hour interval
	end

end