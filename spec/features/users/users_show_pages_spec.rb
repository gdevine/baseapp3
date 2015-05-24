require 'rails_helper'

RSpec.describe "User", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  
  describe "Show page" do
    
    before do 
      #create a user for viewing
      @user1 = FactoryGirl.create(:user)
    end
           
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit user_path(@user1) }
        it { should have_title(Settings.site_title + ' | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end
    
    describe "for users" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in user
          visit user_path(@user1)
        end
        it { should have_title(Settings.site_title + ' | Home') }
        it { should have_content("You are not authorized to access this page.") }
        it { should_not have_content("User") }
      end
    end
    
    describe "for superusers" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in superuser
          visit user_path(@user1)
        end
        it { should have_title(Settings.site_title + ' | Home') }
        it { should have_content("You are not authorized to access this page.") }
        it { should_not have_content("User") }
      end
    end   
    
    
    describe "for admins" do
      describe "should show details of the species" do
        before do 
          sign_in admin
          visit user_path(@user1)
        end
        it { should have_title('User View') }
        it { should have_selector('h2', text: "User " + @user1.fullname) }
        it { should_not have_title('| Home') }  
        it { should have_content('First Name') }
        it { should have_content('Surname') }
        it { should have_content('Email') }
        it { should have_content('Role') }
        it { should have_content('Approved') }
        it { should have_content('Date Joined') }
        it { should have_content(@user1.firstname) }
        it { should have_content(@user1.surname) }
        it { should have_content(@user1.email) }
        it { should have_content(@user1.role) }
        it { should have_content(@user1.approved) }
        it { should have_content(@user1.created_at.to_formatted_s(:long_ordinal)) }
        it { should have_link('Options') }
        it { should have_link('Edit User') }
        it { should have_link('Delete User') }

      
        describe "should navigate to correct edit page on following edit link" do
          before { click_link "Edit User" }
          let!(:page_heading) {"Edit User " + @user1.fullname}
          
          it { should have_content(page_heading) }
        end
        
      end
    
    end
    
  end
  
end
