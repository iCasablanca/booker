require 'gcal4ruby'

desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
    include GCal4Ruby
    service = Service.new
    service.authenticate("harjeet.taggar@gmail.com", "irnsofray21")
    calendar = Calendar.find(service, "Work")[0]
    Hour.find(:all).each do |hour|
      if hour.synced == false
        event = Event.new(service, { :calendar => calendar })
        event.title = "Meeting Hours"
        event.start_time = hour.date + 8.hour #hacky way of converting UTC -> PST
        event.end_time = hour.endhours + 9.hour #additional hour to include end of last meeting
        event.where = hour.location
        event.save
        hour.toggle(:synced).save
      end
    end
    
    Slot.find(:all).each do |slot|
      if slot.email? && slot.synced == false
        event = Event.new(service, { :calendar => calendar })
        event.title = slot.email
        event.start_time = slot.start + 8.hour
        event.end_time = slot.end + 8.hour
        event.save
        slot.toggle(:synced).save
      end
    end
end



