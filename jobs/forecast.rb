require 'net/https'
require 'json'
require 'dotenv'

Dotenv.load

forecast_api_key = ENV['FORECAST_API_KEY']

lat = ENV['LATITUDE'] || 40.740673
long = ENV['LONGITUDE'] || -73.994808

SCHEDULER.every '10m', :first_in => 0 do |job|
  weather = ForecastFetcher.get_forecast(forecast_api_key, lat, long)
  send_event('forecast', weather)
end

