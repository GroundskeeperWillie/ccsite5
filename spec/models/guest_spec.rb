require 'spec_helper'

describe Guest do

  let(:user) { FactoryGirl.create(:user) }
  before { @guest = user.guests.build(name: "Laurent Gypsum")}

  subject { @guest }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:diet) }
  its(:user) { should == user }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Guest.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @guest.user_id = nil } 
    it { should_not be_valid }
  end
  describe "when user_id is not present" do
    before { @guest.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @guest.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @guest.name = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with diet that is too long" do
    before { @guest.diet = "a" * 251 }
    it { should_not be_valid }
  end
end
