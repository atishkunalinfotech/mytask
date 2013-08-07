require 'spec_helper'

describe "LayoutLinks" do
  describe "GET /layout_links" do
    it "should have a log in page at '/'" do
		get '/'
		response.should be_success
    end
  end
end
