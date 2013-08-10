class Guest < ActiveRecord::Base
  attr_accessible :diet, :name, :bus, :wedding, :brunch
  belongs_to :user
  
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 40}
  validates :diet, length: { maximum: 250}
  
  default_scope order(:name)
end
