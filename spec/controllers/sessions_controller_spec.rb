require 'spec_helper'

describe SessionsController do
     render_views
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector('title', :content =>"Sign in")
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


      it "should flash a fail message" do
        post :create, :session => @attr
        response.should have_selector('div',
                                      :content => "Invalid email or password")
      end
    end
    describe "success" do
        
      before(:each) do
        #@user = Factory(:user)
        @attr = { :email => @user_email,
                  :password => @user_password }
      end
      
      it "should sign the user in" do
        post :create , :session => @attr
        controller.current_user.should == @task
        controller.should be_signed_in
      end
      
      it "should redirect to the user's show page" do
        post :create, :session => @attr
        response.should redirect_to(task_path(@task))
      end

    end
  end

   describe "DELETE 'destroy'" do

    it "should sign out user (destroy session)" do
      delete :destroy
      controller.should_not be_signed_in
    end
    it "should sign a user out" do
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end
end
