require 'rails_helper'

RSpec.describe "User", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  
  describe "Index page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit users_path }
        it { should have_title(Settings.site_title + ' | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end
    
    describe "for users" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in user
          visit users_path
        end
        it { should have_title(Settings.site_title + ' | Home') }
        it { should have_content("You are not authorized to access this page.") }
        it { should_not have_content("User List") }
      end
    end
    
    describe "for superusers" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in superuser
          visit users_path
        end
        it { should have_title(Settings.site_title + ' | Home') }
        it { should have_content("You are not authorized to access this page.") }
        it { should_not have_content("User List") }
      end
    end    
 
 
    describe "for admins" do
      before do 
        #create a user for populating the table
        @user1 = FactoryGirl.create(:user)
        sign_in admin
        visit users_path
      end
        
      it { should have_title(Settings.site_title + ' | User List') }
      it { should have_content("User List") }
      it { should have_content('Name') }
      it { should have_content('Email') }        
      it { should have_content('Role') }      
      it { should have_content(@user1.fullname) }
      it { should have_content(@user1.email) }
      it { should have_content(@user1.role) }
      it { should have_link('View', :href => user_path(@user1)) }
      
      describe "should navigate to correct page on following view link" do
        before { find("a[href='#{user_path(@user1)}']").click }
        it { should have_selector('h2', text: "User " + @user1.fullname) }  
      end
    
    end   
   
  end

end
