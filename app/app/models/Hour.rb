class Hour < ActiveRecord::Base
  has_many :slots, :dependent => :destroy

  attr_accessible :location, :date, :start, :number_slots
end
