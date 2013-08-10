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

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :guests_attributes
  has_secure_password
  has_many :guests, dependent: :destroy
  has_one :party

  accepts_nested_attributes_for :guests
    
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  
  validates :name, :presence => true, :length => {:maximum => 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, 
                :format => { :with => VALID_EMAIL_REGEX },
                :uniqueness => { :case_sensitive => false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :update, :unless => lambda{ |user| user.password.blank? }
  
  def feed
    Guest.where("user_id = ?", id)
  end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
