require 'google_util'

desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
    oauth_consumer = OAuth::Consumer.new("high-stream-410.heroku.com", "mhBqC4iClJ78ebc3UOH+9GTM")
    access_token = OAuth::AccessToken.new(oauth_consumer, User.find(1).oauth_token, User.find(1).oauth_secret)

    uri = URI.parse("https://www.google.com/calendar/feeds/default/private/full")
    client = Google::Client.new(access_token, '2.0');

    Hour.find(:all).each do |hour|
      if hour.synced == false

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
            <gd:where valueString=#{hour.location}></gd:where>
            <gd:when startTime=#{hour.date + 8.hour}
              endTime=#{hour.endhours + 9.hour}></gd:when>
          </entry>
EOF
        post_headers = { "Content-Type" => "application/atom+xml" }
        client.post(uri.to_s, entry, post_headers)
        hour.toggle(:synced).save
      end
    end
    
    Slot.find(:all).each do |slot|
      if slot.email? && slot.synced == false
        entry = <<EOF
          <entry xmlns='http://www.w3.org/2005/Atom'
              xmlns:gd='http://schemas.google.com/g/2005'>
            <category scheme='http://schemas.google.com/g/2005#kind'
              term='http://schemas.google.com/g/2005#event'></category>
            <title type='text'>'This is meeting'</title>
            <content type='text'></content>
            <gd:transparency
              value='http://schemas.google.com/g/2005#event.opaque'>
            </gd:transparency>
            <gd:eventStatus
              value='http://schemas.google.com/g/2005#event.confirmed'>
            </gd:eventStatus>
            <gd:where valueString=""></gd:where>
            <gd:when startTime=2011-03-10T15:00:00.000Z'
              endTime='2011-03-10T17:00:00.000Z'></gd:when>
          </entry>
EOF
        post_headers = { "Content-Type" => "application/atom+xml" }
        client.post(uri.to_s, entry, post_headers)
        slot.toggle(:synced).save
      end
    end
end

