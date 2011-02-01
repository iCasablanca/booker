class Hour < ActiveRecord::Base
  has_many :slots

  attr_accessible :location, :date, :start, :number_slots
end
