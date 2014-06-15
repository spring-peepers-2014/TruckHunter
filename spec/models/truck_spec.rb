require 'spec_helper'

describe Truck do
	context "validations" do
		it "is valid with a name" do
			truck = Truck.new(name: "Kickass Sandwiches")
			expect(truck).to be_valid
		end
		
		it "has a valid factory" do
			expect(FactoryGirl.build(:truck)).to be_valid
		end
		
		it "is invalid valid without a name" do
			truck = FactoryGirl.build(:truck, name: nil)
				expect(truck).to be_invalid
			end

		it "is invalid with a duplicate twitter_handle" do
			FactoryGirl.create(:truck, twitter_handle: "kickass_sandwiches_nyc")
			truck = FactoryGirl.build(:truck, twitter_handle: "kickass_sandwiches_nyc")
			expect(truck).to be_invalid
		end
	end

	context "associations" do
		it "" do
		end

	end

end