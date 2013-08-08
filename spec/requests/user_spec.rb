require 'spec_helper'

describe "Users" do
  
  describe "signup" do

    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit sign_up_path
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
          fill_in "Password Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make a new user" do
        lambda do
          visit sign_up_path
          fill_in "Email", :with => "user@example.com"
          fill_in "Password", :with => "foobar"
          fill_in "Password Confirmation", :with => "foobar"
          click_button
          
          response.should render_template("users/new")
        end.should change(User, :count).by(1)
      end
    end
  end

  describe "signin" do
    
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in "Email", :with => ""
        fill_in "Password", :with => ""
        click_button
        response.should have_selector('div',
                                      :content => "Invalid")
        response.should render_template('sessions/new')
      end
    end
    
    describe "success" do
      it "should sign a user in and out" do
        
        visit signin_path
        fill_in "Email", :with => @user_email
        fill_in "Password", :with => @user_password
        click_button
      end
    end
  end
end