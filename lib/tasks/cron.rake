require 'google_util'

desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
   Hour.find(:all).each do |hour|
      if hour.synced == false
        oauth_consumer = OAuth::Consumer.new("high-stream-410.heroku.com", "mhBqC4iClJ78ebc3UOH+9GTM")
        access_token = OAuth::AccessToken.new(oauth_consumer, User.find(1).oauth_token,  User.find(1).oauth_secret)
        client = Google::Client.new(access_token, '2.0');

        entry = <<EOF
        <entry xmlns='http://www.w3.org/2005/Atom'
            xmlns:gd='http://schemas.google.com/g/2005'>
          <category scheme='http://schemas.google.com/g/2005#kind'
            term='http://schemas.google.com/g/2005#event'></category>
          <title type='text'>Meeting Hours</title>
          <content type='text'></content>
          <gd:transparency
            value='http://schemas.google.com/g/2005#event.opaque'>
          </gd:transparency>
          <gd:eventStatus
            value='http://schemas.google.com/g/2005#event.confirmed'>
          </gd:eventStatus>
          <gd:where valueString="#{hour.location}"></gd:where>
          <gd:when startTime="#{hour.date.strftime('%Y-%m-%dT%H:%M:%S.000-08:00')}"
            endTime="#{hour.endhours.strftime('%Y-%m-%dT%H:%M:%S.000-08:00')}"></gd:when>
        </entry>
EOF

        uri = URI.parse("https://www.google.com/calendar/feeds/default/private/full")
        client = Google::Client.new(access_token, '2.0');
    
        post_headers = { "Content-Type" => "application/atom+xml" }
        client.post(uri.to_s, entry, post_headers)
        hour.toggle(:synced).save
      end
   end   
   Slot.find(:all).each do |slot|
      if slot.email? && slot.synced == false
        oauth_consumer = OAuth::Consumer.new("high-stream-410.heroku.com", "mhBqC4iClJ78ebc3UOH+9GTM")
        access_token = OAuth::AccessToken.new(oauth_consumer, User.find(1).oauth_token, User.find(1).oauth_secret)
        client = Google::Client.new(access_token, '2.0');
        hour = slot.hour_id
        slot.location = Hour.find(hour).location

        entry = <<EOF
        <entry xmlns='http://www.w3.org/2005/Atom'
            xmlns:gd='http://schemas.google.com/g/2005'>
          <category scheme='http://schemas.google.com/g/2005#kind'
            term='http://schemas.google.com/g/2005#event'></category>
          <title type='text'>#{slot.email}</title>
          <content type='text'></content>
          <gd:transparency
            value='http://schemas.google.com/g/2005#event.opaque'>
          </gd:transparency>
          <gd:eventStatus
            value='http://schemas.google.com/g/2005#event.confirmed'>
          </gd:eventStatus>
          <gd:where valueString="#{slot.location}"></gd:where>
          <gd:when startTime="#{slot.start.strftime('%Y-%m-%dT%H:%M:%S.000-08:00')}"
            endTime="#{slot.end.strftime('%Y-%m-%dT%H:%M:%S.000-08:00')}"></gd:when>
        </entry>
EOF

        uri = URI.parse("https://www.google.com/calendar/feeds/default/private/full")
        client = Google::Client.new(access_token, '2.0');

        post_headers = { "Content-Type" => "application/atom+xml" }
        client.post(uri.to_s, entry, post_headers)
        slot.toggle(:synced).save
      end
    end
end

