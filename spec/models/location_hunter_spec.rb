require 'spec_helper'

describe LocationHunter do
	context "regular expressions matching" do
		it "returns correct cross-streets from short-string" do
			expect( LocationHunter.get_coordinates("40th and 5th") ).to eq("40th and 5th")
		end

		it "returns the correct cross-streets from taco tweet" do
			expect( LocationHunter.get_coordinates("We got kicked out of 50th. Now on 45th and 6th. Come get your taco fix....no line!") ).to eq("45th and 6th")
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
			expect( LocationHunter.get_coordinates("It feels like summer so your lunch should taste like summer! #BigRed is serving summer on toasted top-split rolls on 50th & 6th!") ).to eq("50th & 6th")
		end

		it "returns the correct cross-streets from 'btwn' statement" do
			expect( LocationHunter.get_coordinates("Hello #MidtownWest! How does a #Vegan platter for lunch sound? Get one today on 46th btwn 5th & 6th! #LebaneseLunch http://t.co/yp5CmLswcn") ).to eq("46th and 5th")
		end

		it "returns the correct park string from 'park' statement" do
			expect( LocationHunter.get_coordinates("We'll be at Bryant Park today. Enjoy your burrito") ).to eq("Bryant Park")
		end

		it "returns the correct gsubs on parentheses" do
			expect( LocationHunter.get_coordinates("()()()(th street and 5") ).to eq("th street and 5")
		end

		it "returns the correct gsubs on @ and b/t" do
			expect( LocationHunter.get_coordinates("we're at @@sdflkj and b/ttree") ).to eq(" sdflkj and andtree")
		end

		it "returns the correct gsubs on 'btw' statement" do
			expect( LocationHunter.get_coordinates("Come we're btw Madison and lex on 9th street yay!!") ).to eq("we're and Madison")
		end

		it "returns the correct gsubs on food words" do
			expect( LocationHunter.get_coordinates("Come and try sandwiches at Central between lunch and dinner") ).to eq("Central and")
		end

		it "returns the corrent two words before 'park'" do
			expect( LocationHunter.get_coordinates("No cart in DUMBO today or tomorrow due to mechanical problems. We'll be back this weekend in BK Bridge Park. Sorry for any inconvenience!") ).to eq("BK Bridge Park")
		end

		it "returns false when there is no location to catch" do
			expect( LocationHunter.get_coordinates("Catch #WorldCup futbol action @CalexicoNYC they are doing #HappyHour during every game 2-for-1 drafts, well drinks & margaritas! #LES") ).to eq(false)
		end

		it "returns correct gsub on bang symbol" do
			expect( LocationHunter.get_coordinates("It feels like summer so your lunch should taste like summer! #BigRed is serving summer on toasted top-split rolls on 50th & 6th") ).to eq("50th & 6th")
		end

		it "returns correct cross-streets before 'st'" do
			expect( LocationHunter.get_coordinates("#BigRed was kicked out of 50th & 6th, stayed tuned for our next location!") ).to eq("50th & 6th, st")
		end

		it "returns correct gsub on bang symbol" do
			expect( LocationHunter.get_coordinates("Kasar truck working the wall street, Wall street and Williams until 4:30pm and at 43 and 6th until 8 pm") ).to eq("Wall street and Williams")
		end

		it "returns correct numbered street address" do
			expect( LocationHunter.get_coordinates("Serving Now at Hudson/King St - 375 Hudson Street New York From 7:30AM Until 3:00PM EDT http://t.co/FlYhEJ5ABQ") ).to eq("375 Hudson Street")
		end

		it "returns false on string that mimicks location" do
			expect( LocationHunter.get_coordinates("Our Feature in Food Network's Eat St. Season 3 #Greekfood #Streetfood http://t.co/DPPhJLzMIx") ).to eq(false)
		end

		it "returns correct cross-streets for string with multiple types of location info" do
			expect( LocationHunter.get_coordinates("Morning y'all! Catch us at Soho (Varick & Vandam) for lunch and Union Sq (14th & 3rd ave) all day. GO KOREA! ") ).to eq("14th & 3rd ave")
		end

		it "returns simple cross-streets without extra words" do
			expect( LocationHunter.get_coordinates("56th & Broadway it is.") ).to eq("56th & Broadway")
		end

		it "returns theseaport for twitter handle of @theseaport" do
			expect( LocationHunter.get_coordinates("We are open at @TheSeaport and it's national cannoli day stop by for our #cannoli specials #lbttrucknyc#cannolitrucknyc#cannoli") ).to eq("TheSeaport")
		end

		it "returns south street seaport for the full name without spaces" do
			expect( LocationHunter.get_coordinates("It's our favorite day of the year it's NATIONAL CANNOLI DAY and we are open at the southstreetseaport 
Come by... http://fb.me/18aKS2L79") ).to eq("southstreetseaport")
		end

		it "returns south street seaport for the full name with spaces" do
			expect( LocationHunter.get_coordinates("Did you know today is National Cannoli Day. Stop by the truck at the south street seaport and celebrate with a... http://fb.me/3jpXbdknb ") ).to eq("south street seaport")
		end

	end
end