require 'spec_helper'

describe Admin do
	context "validations" do
		it "is valid with a username and password" do
			admin = Admin.new(username: "admin", password_digest: "password")
			expect(admin).to be_valid
		end
	end

end