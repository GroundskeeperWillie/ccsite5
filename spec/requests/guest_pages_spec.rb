require 'spec_helper'

describe "Guest pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "guest creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a guest" do
        expect { click_button "Post" }.not_to change(Guest, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'name', with: "Lorem ipsum" }
      it "should create a guest" do
        expect { click_button "Post" }.to change(Guest, :count).by(1)
      end
    end
  end
  describe "guest destruction" do
      before { FactoryGirl.create(:guest, user: user) }

      describe "as correct user" do
        before { visit root_path }

        it "should delete a guest" do
          expect { click_link "delete" }.to change(Guest, :count).by(-1)
        end
      end
    end
end
