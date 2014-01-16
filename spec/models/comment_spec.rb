require 'spec_helper'

describe Comment do
  let(:user) { FactoryGirl.create(:user) }
  let(:entry) { FactoryGirl.create(:entry) }
  before do
    @comment = Comment.new(content: "New Comment", user_id: user.id, entry_id: entry.id)
  end

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:entry_id) }
  it { should respond_to(:user) }
  its(:user)  { should eq user }
  it { should respond_to(:entry) }
  its(:entry) { should eq entry }
  
  it { should be_valid }

  describe "when user_id is not present" do
    before { @comment.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when entry_id is not present" do
    before { @comment.entry_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { @comment.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @comment.content = "a" * 161 }
    it { should_not be_valid }
  end
end
