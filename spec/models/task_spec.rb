require 'spec_helper'

describe Task do

	it "should have mytask attributes" do
		User.create( :mytask => "value for content").should respond_to(:tasks) 
	end

	it "should reject when mytask is nil" do 
		User.create( :mytask => "").should_not be_valid 
	end

	it "should reject if status not decleared " do
		User.create( :status => "").should_not be_valid
	end
end
