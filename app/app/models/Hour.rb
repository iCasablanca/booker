class Hour < ActiveRecord::Base
  attr_accessible :date, :start, :location, :number_slots
  has_many :slots
  
  after_create :fill_in_slots

  def fill_in_slots
    start = self.date
    numbslots = self.number_slots
    endtime = self.date + numbslots.hour

    while start < endtime
      Slot.create(:start => start, :end => start + 1.hour, :hour_id => self.id)
      start += 1.hour
    end
  end



end
