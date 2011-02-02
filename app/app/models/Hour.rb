class Hour < ActiveRecord::Base
  attr_accessible :date, :start, :location, :number_slots
  has_many :slots
end
