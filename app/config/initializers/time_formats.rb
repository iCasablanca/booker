Time::DATE_FORMATS[:month_and_year] = "%B %Y"
Time::DATE_FORMATS[:pretty] = lambda { |time| time.strftime("%A, %b %e at %l:%M") + time.strftime("%p").downcase }
Time::DATE_FORMATS[:slot] = lambda { |time| time.strftime("%l:%M") + time.strftime("%p").downcase }

