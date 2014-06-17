require 'spec_helper'

describe LocationHunter do
	context "regular expressions matching" do
		it "returns correct cross-streets from short-string" do
			expect( LocationHunter.get_coordinates("40th and 5th") ).to eq("40th and 5th")
		end

		it "returns the correct cross-streets from taco tweet" do
			expect( LocationHunter.get_coordinates("We got kicked out of 50th. Now on 45th and 6th. Come get your taco fix....no line!") ).to eq("45th and 6th.")
		end

		it "returns the correct cross-streets from single word cross-streets" do
			expect( LocationHunter.get_coordinates("RT @DumboNYC: Get your lunch @dumbolot today! @KimchiTruck @carlssteaks & @SweetChiliNYC are there on Jay/Water Streets #Dumbo") ).to eq("on Jay/Water Streets")
		end

		it "returns seaport from tweet with seaport" do
			expect( LocationHunter.get_coordinates("Bessie's at @TheSeaport, call (646) 504-6455 to pre-order or @FoodtoEat.com. Sandwich menu always @houstonhallnyc") ).to eq("TheSeaport")
		end

		it "returns the correct cross-streets from tweet with no explicit street words" do
			expect( LocationHunter.get_coordinates("Show some RT love for #frankenfood truck by @SpikeTV on water and maiden nyc Free food and get a glimpse of the hottest show airs 6/22 10pm!") ).to eq("water and maiden")
		end

		it "returns the correct cross-streets from 'at' statement" do
			expect( LocationHunter.get_coordinates("Hey FiDi! We're over at broad st and Pearl st with the best chicken tenders in NYC. We'll be there from 11-3!") ).to eq("broad st and Pearl st")
		end

		it "returns false from tweet that regex doesn't match" do
			expect( LocationHunter.get_coordinates("JP testing out some of our new cocktails. Full Bar, badass drinks #MexicueTimesSq. #driiiiinks… ") ).to eq(false)
		end

		it "returns the correct cross-streets from 'st' statement" do
			expect( LocationHunter.get_coordinates("Due to parking restrictions on 36st, we are parked at 38st and Broadway today") ).to eq(" 38st and Broadway")
		end

		it "returns the correct cross-streets from 'and' statement with explicit street" do
			expect( LocationHunter.get_coordinates("Kasar truck working the wall street, Wall street and Williams until 4:30pm and at 43 and 6th until 8 pm") ).to eq("Wall street and Williams")
		end

		it "returns the correct cross-streets from 'on' statement" do
			expect( LocationHunter.get_coordinates("Off to Astoria for one of our final nights! Come catch the truck on Ditmars & 31st opening at 5:30pm #tacotrucklove #LetsGoMexico !!!") ).to eq("Ditmars & 31st")
		end

		it "returns the correct cross-streets from 'th' appended street names" do
			expect( LocationHunter.get_coordinates("It feels like summer so your lunch should taste like summer! #BigRed is serving summer on toasted top-split rolls on 50th & 6th!") ).to eq("50th & 6th!")
		end

		it "returns the correct cross-streets from 'btwn' statement" do
			expect( LocationHunter.get_coordinates("Hello #MidtownWest! How does a #Vegan platter for lunch sound? Get one today on 46th btwn 5th & 6th! #LebaneseLunch http://t.co/yp5CmLswcn") ).to eq("46th and 5th")
		end

	end
end