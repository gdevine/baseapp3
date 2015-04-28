require 'rails_helper'

RSpec.describe "Static Pages", type: :feature do
  
  subject { page }
  
  describe "Home page" do 
    
    describe "when not logged in" do
      before { visit root_path }
      it { should have_title(full_title('Home')) }
      it { should have_content('Sign In') }
      it { should have_content('Register') }
    end
    
    describe "when logged in" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end
      it { should have_content('Sign Out, '+ user.firstname.capitalize) }
      it { should_not have_content('Sign In') }
      it { should have_title(full_title('Home')) }
    end
    
  end
  
  
  describe "Help page" do
    
    describe "when not logged in" do
      before { visit help_path }
      it { should have_title('Help') }
      it { should have_content('Sign In') }
    end
    
    describe "when logged in" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit help_path
      end

      it { should have_content('Sign Out, '+user.firstname.capitalize) }
      it { should_not have_content('Sign In') }
      it { should have_title(full_title('Help')) }
    end
  
  end

  
  describe "About page" do
    before { visit about_path }

    it { should have_title(full_title('About')) }
  end
  
  
  describe "Contact page" do
    before { visit contact_path }

    it { should have_title(full_title('Contact')) }
  end
  
end