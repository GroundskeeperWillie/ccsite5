# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
    
    before do
        @user = User.new(name: "Example User", email: "user@example.com",
                         password: "foobar", password_confirmation: "foobar")
    end
    
    subject { @user }
    
    it { should respond_to(:admin) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:guests) }

    it { should be_valid }
    it { should_not be_admin }

    describe "with admin attribute set to 'true'" do
      before do
        @user.save!
        @user.toggle!(:admin)
      end

      it { should be_admin }
    end
    
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:authenticate) }
    describe "remember token" do
        before { @user.save }
        its(:remember_token) { should_not be_blank }
    end
    describe "guest associations" do

      before { @user.save }
        it "should destroy associated microposts" do
          guests = @user.guests.dup
          @user.destroy
          guests.should be_empty
          guests.each do |guest|
            Guest.find_by_id(guest.id).should be_nil
          end
        end
      end
   
end
