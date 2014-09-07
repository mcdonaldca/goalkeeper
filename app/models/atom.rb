class Atom < ActiveRecord::Base
  attr_accessible :completed, :day, :goal_id, :ignore, :month, :note, :posted_at, :proof, :success, :year
  
  belongs_to :goal
end
