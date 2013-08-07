require 'spec_helper'

describe SessionsController do
     render_views
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do
  
    describe 'invalid signin' do
      
      before(:each) do
        @attr = { :email => 'email@example.com', :password => 'invalid' }
      end
      
      it 'should re-render the new page' do
        post :create, :session => @attr
        response.should render_template('new')
      end
    end
  end

   describe "DELETE 'destroy'" do
    it "should sign a user out" do
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end
end
