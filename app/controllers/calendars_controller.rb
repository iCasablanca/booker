require 'google_util'
require 'rest_client'

class CalendarsController < ApplicationController
  def index
    oauth_consumer = OAuth::Consumer.new("high-stream-410.heroku.com", "mhBqC4iClJ78ebc3UOH+9GTM")
    access_token = OAuth::AccessToken.new(oauth_consumer, current_user.oauth_token, current_user.oauth_secret)
    client = Google::Client.new(access_token, '2.0');

    # Here is where you specify the get. You can pass parameters into the hash. See the gdata spec.
    feed = client.get('https://www.google.com/calendar/feeds/default/allcalendars/full', {})

    output = ""
    feed.elements.each('//entry') do |entry|
      output += entry.elements["title"].text + "<br>"
    end

    render :text => output
  end

  def newevent
    oauth_consumer = OAuth::Consumer.new("high-stream-410.heroku.com", "mhBqC4iClJ78ebc3UOH+9GTM")
    access_token = OAuth::AccessToken.new(oauth_consumer, current_user.oauth_token, current_user.oauth_secret)
    client = Google::Client.new(access_token, '2.0');


    entry = <<EOF
    <entry xmlns='http://www.w3.org/2005/Atom'
        xmlns:gd='http://schemas.google.com/g/2005'>
      <category scheme='http://schemas.google.com/g/2005#kind'
        term='http://schemas.google.com/g/2005#event'></category>
      <title type='text'>Testing out Calendar API</title>
        <content type='text'>Trying to be a hacker.</content>
      <gd:transparency
        value='http://schemas.google.com/g/2005#event.opaque'>
      </gd:transparency>
      <gd:eventStatus
        value='http://schemas.google.com/g/2005#event.confirmed'>
      </gd:eventStatus>
      <gd:where valueString='1024 Filbert Street'></gd:where>
      <gd:when startTime='2011-03-10T15:00:00.000Z'
        endTime='2011-03-10T17:00:00.000Z'></gd:when>
    </entry>
EOF

  RestClient.post "https://www.google.com/calendar/feeds/default/private/full", entry, :content_type => 'application/atom+xml'

  end

end
