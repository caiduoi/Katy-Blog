require 'spec_helper'

describe Entry do
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @entry = Entry.new(title: "Entry Title", body: "Entry Body", user_id: user.id)
  end

  subject { @entry }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  
  it { should be_valid }

  describe "when user_id is not present" do
    before { @entry.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank title" do
    before { @entry.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @entry.title = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "with blank body" do
    before { @entry.body = " " }
    it { should_not be_valid }
  end

  describe "with body that is too long" do
    before { @entry.body = "a" * 501 }
    it { should_not be_valid }
  end
  
end
