require 'sun_time'

lat = ENV['LATITUDE'] || 40.681893
long = ENV['LONGITUDE'] || -73.978801

SCHEDULER.every '6h', :first_in => 0 do |job|
  sun_time = SunTime.new(DateTime.now, lat, long)
  sunrise = sun_time.sunrise.localtime.strftime "%l:%M %p"
  sunset = sun_time.sunset.localtime.strftime "%l:%M %p"

  send_event('sunrise', items: [{label: "Sunrise", value: sunrise}, {label: "Sunset", value: sunset}])
end
