require 'spec_helper'

describe "Static pages" do
  describe "Splash page" do
    it "should have the content 2014" do
      visit '/static_pages/splash'
      page.should have_content('2014')
    end
  end
end