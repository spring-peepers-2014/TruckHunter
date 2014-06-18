class LocationHunter

	def self.parse_tweet(tweet)
		cleaned_tweet = tweet.gsub("#", "")
		cleaned_tweet.gsub!("&amp;", "&")
		seaport = /theseaport/i.match(cleaned_tweet).to_s
		return seaport unless seaport == ""
		my_match = /\s(at|on)\s\S+\s(and|&)\s\S+|((\d+(th|st|nd|rd)\s)|(\S+))\s((ave|avenue|st|street)?.?\s?(b\/t|bet|btw|btwn|between).?\s)(\d+(th|st|nd|rd)|\S+)|\S+\s(and|&)?\s\S+?\s(Avenue|Ave|Street|St)|(\s)(@|at|on)\s+((?:\S+\s)?\S*(and|&)\S*(?:\s\S+)?)|\S\d+\s\b\w+\b\s(Avenue|Ave|Street|St)|\A?^?\d+\s(\b\w+\b\s)+(Avenue|Ave|Street|St)|(\b\w+\b\s){2}Park\b|(\b\w+\b\s)(Avenue|Ave|Street|St)\sand?\s(\b\w+\b\s)(St|Street)|(\b\w+\b\s)between(\s\b\w+\b)|\d+(th)\s(and|&)\s\S+|\S+\s(and|&)\s\d+(th)|\S+\s((street|st|ave|avenue)\s)(and|&)\s\S+|(at|on|@)\s\S+\s(street|ave|avenue)s?/i.match(cleaned_tweet).to_s
	end

	def self.clean_match(match)

		match.gsub!("(", "")
		match.gsub!(")", "")
		match.gsub!("at ", "")
		match.gsub!(" on ", "")
		match.gsub!("@", "")
		match.gsub!("between", "and")
		match.gsub!("bet", "and")
		match.gsub!("btwn", "and")
		match.gsub!("btw.", "and")
		match.gsub!("btw", "and")
		match.gsub!("b/t", "and")
		match.gsub!(/\s?sandwich\s?/i, "")
		match.gsub!(/\s?breakfast\s?/i, "")
		match.gsub!(/\s?lunch\s?/i, "")
		match.gsub!(/\s?dinner\s?/i, "")
		match.gsub!(/\s?down\s?/i, "")
		match.gsub!(/\s?try\s?/i, "")

		return false if match == ""
		match
	end


	def self.get_coordinates(tweet_body)
		match = parse_tweet(tweet_body)
		cleaned_match = clean_match(match)
		return cleaned_match
	end

end

