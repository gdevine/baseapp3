require 'rails_helper'

RSpec.describe "User", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  
  describe "Edit page" do
    
    before do 
      #create a user and an admin for editing
      @user1 = FactoryGirl.create(:user)
      @admin1 = FactoryGirl.create(:admin)
    end
           
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit edit_user_path(@user1) }
        it { should have_title(Settings.site_title + ' | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end
    
    describe "for users" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in user
          visit edit_user_path(@user1)
        end
        it { should have_title(Settings.site_title + ' | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end    
   
    
    describe "for superusers" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in superuser
          visit edit_user_path(@user1)
        end
        it { should have_title(Settings.site_title + ' | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end  


    describe "for admins" do
      before do
        sign_in admin
        visit edit_user_path(@user1)
      end
              
      describe "should be given access to edit user" do
        it { should have_title(Settings.site_title + ' | Edit User') }
        it { should have_selector('h2', text: "Edit User "+@user1.fullname) }
        it { should_not have_content('First Name') }
        it { should_not have_content('Surname') }
        it { should_not have_content('Email') }
        it { should have_content('Role') }
        it { should have_content('Approved?') }
      end
      
      describe "not changing any information" do                 
        it "should not change the number of users" do
          expect{ click_button "Update" }.to change{User.count}.by(0)
        end             
        
        describe "should return to view" do
          before { click_button "Update" }
          it { should have_title('User View') }
          it { should have_selector('h2', text: "User " + @user1.fullname) }
        end
      end
  
      describe "changing to superuser role" do      
        before do
          find('#role').find("option[value='superuser']").select_option  
        end
                   
        it "should not change the number of users" do
          expect{ click_button "Update" }.to change{User.count}.by(0)
        end             
        
        describe "should return to view with updated info" do
          before { click_button "Update" }
          it { should have_title('User View') }
          it { should have_selector('h2', text: "User " + @user1.fullname) }
          it { should have_content('superuser') }
        end
      end
      
    end 

    describe "for admins editing their own account" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in admin
          visit edit_user_path(admin)
        end
        it { should have_title(Settings.site_title + ' | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end  
 
 
    describe "for admins editing another admin account" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in admin
          visit edit_user_path(@admin1)
        end
        describe "should be given access to edit adminuser" do
          it { should have_title(Settings.site_title + ' | Edit User') }
          it { should have_selector('h2', text: "Edit User "+ @admin1.fullname) }
          it { should_not have_content('First Name') }
          it { should_not have_content('Surname') }
          it { should_not have_content('Email') }
          it { should have_content('Role') }
          it { should have_content('Approved?') }
        end
      
      end
    end  
  end
 
  
end
