class User < ActiveRecord::Base
  attr_accessible :birthday, :email, :first, :gender, :last, :password, :password_confirmation
  validates :email, :presence => true, :uniqueness => true
  validates :first, :presence => true
  validates :last, :presence => true
  validates :gender, :presence => true
  validates :birthday, :presence => true
  validates :password, :presence => true, :confirmation => true

  has_many :goals
end
