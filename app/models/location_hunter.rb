module LocationHunter

	def parse_tweet(tweet)
		cleaned_tweet = tweet.gsub("#", "")
		cleaned_tweet.gsub!("&amp;", "&")
		my_match = /(at|on)\s\S+(and|&)\s\S+|((\d+(th|st|nd|rd)\s)|(\S+))\s((ave|avenue|st|street)?.?\s?(b\/t|btw|btwn|between).?\s)(\d+(th|st|nd|rd)|\S+)|\S+\s(and|&)?\s\S+?\s(Avenue|Ave|Street|St)|(\s)?(@|(\s)?at|(\s)?on)\s+((?:\S+\s)?\S*(and|&)\S*(?:\s\S+)?)|\S\d+\s\b\w+\b\s(Avenue|Ave|Street|St)|\A?^?\d+\s(\b\w+\b\s)+(Avenue|Ave|Street|St)|(\b\w+\b\s){2}Park|(\b\w+\b\s)(Avenue|Ave|Street|St)\sand?\s(\b\w+\b\s)(St|Street)|(\b\w+\b\s)between(\s\b\w+\b)/i.match(cleaned_tweet).to_s
	end

	def clean_match(match)
		match = /seaport/i.match(match).to_s if match == ""

		match.gsub!("(", "")
		match.gsub!(")", "")
		match.gsub!("at ", "")
		match.gsub!(" on ", "")
		match.gsub!("@", "")
		match.gsub!("between", "and")
		match.gsub!("bet", "and")
		match.gsub!("btw", "and")
		match.gsub!("btw.", "and")
		match.gsub!("b/t", "and")
		match.gsub!("btwn", "and")
		match.gsub!(/\s?sandwich\s?/, "")
		match.gsub!(/\s?breakfast\s?/, "")
		match.gsub!(/\s?lunch\s?/, "")
		match.gsub!(/\s?dinner\s?/, "")
		match.gsub!(/\s?down\s?/, "")
		match.gsub!(/\s?try\s?/, "")

		return false if match == ""
		match
	end


	def get_coordinates(tweet_body)
		match = parse_tweet(tweet_body)
		cleaned_match = clean_match(match)

		self.update_attributes(address: "#{cleaned_match}, New York City", location_last_updated: Time.now) if cleaned_match
		cleaned_match
	end

end
