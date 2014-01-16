require 'spec_helper'

describe "Comment pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:entry) { FactoryGirl.create(:entry) }
  before { sign_in user }

  describe "comment creation" do
    before { visit entry_path(FactoryGirl.create(:entry)) }

    describe "with invalid information" do #Xem hàm create (ko lưu đc)
      it "should not create a comment" do
        expect { click_button submit }.not_to change(Comment, :count)
      end
      
      describe "error messages" do
        before { click_button submit }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'Content', with: "Lorem ipsum" }
      it "should create a comment" do
        expect { click_button "Post" }.to change(Comment, :count).by(1)
      end
    end
  end
end