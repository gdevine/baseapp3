require 'rails_helper'

RSpec.describe "User", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
 
  describe "User Deletion" do
    
    before do 
      @user = FactoryGirl.create(:user)
    end     
    
    
    describe "for admins" do
      before do
        sign_in admin
        visit user_path(@user)
      end
    
      it "should delete" do
        expect { click_link "Delete User" }.to change(User, :count).by(-1)
      end
    
      describe "should revert to user list page with success message and updated info" do
        before { click_link "Delete User" }
        it { should have_content('User Deleted!') }
        it { should have_content(admin.fullname) }
        it { should_not have_content('No Users found') }
        it { should have_title(full_title('User List')) }  
        it { should_not have_link('View', :href => user_path(@user)) }
        it { should have_link('View', :href => user_path(admin)) }
      end
  
    end 
  end
  
end
