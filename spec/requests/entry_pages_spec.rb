require 'spec_helper'

describe "EntryPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "entry creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a entry" do
        expect { click_button "Post" }.not_to change(Entry, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'entry_content', with: "Lorem ipsum" }
      it "should create a entry" do
        expect { click_button "Post" }.to change(Entry, :count).by(1)
      end
    end
  end
  
  describe "entry destruction" do
    before { FactoryGirl.create(:entry, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a entry" do
        expect { click_link "delete" }.to change(Entry, :count).by(-1)
      end
    end
  end
end
