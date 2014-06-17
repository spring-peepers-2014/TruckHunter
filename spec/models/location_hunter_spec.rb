require 'spec_helper'

describe LocationHunter do
	context "regular expressions matching" do
		it "return correct cross-streets from short-string" do
			expect( LocationHunter.get_coordinates("40th and 5th") ).to eq("40th and 5th")
		end

		it "return the correct cross-streets from tweet" do
			expect( LocationHunter.get_coordinates("We got kicked out of 50th. Now on 45th and 6th. Come get your taco fix....no line!") ).to eq("45th and 6th.")
		end


		it "return the correct cross-streets from tweet" do
			expect( LocationHunter.get_coordinates("We got kicked out of 50th. Now on 45th and 6th. Come get your taco fix....no line!") ).to eq("45th and 6th.")
		end

		


	end
end