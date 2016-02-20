require 'rubygems'
require 'nokogiri'
require 'restclient'

def revvy_page
  Nokogiri::HTML(RestClient.get('http://www.revelstokemountainresort.com/conditions/snow-report'))
end

def snow_conditions
  @snow_conditions ||= revvy_page.css('section.snow-report')
end

def new_snow
  snow_conditions.css('.new-snow strong')[1].text.to_i
end

def base_depth
  snow_conditions.css('div div strong')[1].text.to_i
end

def season_total
  snow_conditions.css('div div strong')[3].text.to_i
end

def last_hour
  regex = /Last Hour(\d*) cm/
  regex.match(snow_conditions.css('div div')[2].text)[1].to_i
end

def last_24_hours
  regex = /24 Hours(\d*) cm/
  regex.match(snow_conditions.css('div div')[3].text)[1].to_i
end

def last_7_days
  regex = /7 Days(\d*) cm/
  regex.match(snow_conditions.css('div div')[4].text)[1].to_i
end

def base_temp
  snow_conditions.css('div div strong')[14].text.to_i
end

def ripper_temp
  snow_conditions.css('div div strong')[12].text.to_i
end

def peak_temp
  snow_conditions.css('div div strong')[10].text.to_i
end

def conditions
  {
    new_snow: new_snow,
    base_depth: base_depth,
    season_total: season_total,
    last_hour: last_hour,
    last_24_hours: last_24_hours,
    last_7_days: last_7_days,
    base_temp: base_temp,
    peak_temp: peak_temp,
    ripper_temp: ripper_temp,
  }
end
