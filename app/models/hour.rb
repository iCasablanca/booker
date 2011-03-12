class Hour < ActiveRecord::Base
  attr_accessible :date, :start, :location, :number_slots
  has_many :slots
  
  after_create :fill_in_slots

  def fill_in_slots
    start = self.date
    endtime = self.date + (self.number_slots).hour

    while start < endtime
      Slot.create(:start => start, :end => start + 1.hour, :hour_id => self.id)
      start += 1.hour
    end
  end

  def endhours
    self.date + (self.number_slots - 1).hour
  end
  
  def endingtime
    self.date + (self.number_slots).hour
  end



end
