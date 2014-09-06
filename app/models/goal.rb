class Goal < ActiveRecord::Base
  attr_accessible :action, :charity, :duration, :frequency
  validates :action, :presence => true
  validates :charity, :presence => true
  validates :duration, :presence => true
  validates :frequency, :presence => true
  
  belongs_to :user
end
