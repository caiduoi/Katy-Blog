require 'spec_helper'
require 'supports/utilities'

describe "StaticPages" do
  
  subject { page }
  
  describe "Home page" do
    
    before { visit root_path }
    
    it { should have_content('Home') }
    it { should have_title(full_title('Home')) }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:entry, user: user, title: "Entry Title 1", body: "Entry Body 1") 
        FactoryGirl.create(:entry, user: user, title: "Entry Title 2", body: "Entry Body 2")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.title, text: body)
        end
      end
    end
  end
  
  describe "Help page" do
    
    before { visit help_path }
    
    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end
  
  describe "About page" do
    
    before { visit about_path }
    
    it { should have_content('About') }
    it { should have_title(full_title('About')) }
  end
  
  describe "Contact page" do
    
    before { visit contact_path }
    
    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
  
end
