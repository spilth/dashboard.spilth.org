class ForecastFetcher
  def self.get_forecast(forecast_api_key, lat, long)
    http = Net::HTTP.new("api.forecast.io", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    response = http.request(Net::HTTP::Get.new("/forecast/#{forecast_api_key}/#{lat},#{long}?units=us"))
    forecast = JSON.parse(response.body)
    forecast_current_temp  = forecast["currently"]["temperature"].round
    forecast_apparent_temp = forecast["currently"]["apparentTemperature"].round
    forecast_current_icon  = forecast["currently"]["icon"]
    forecast_current_desc  = forecast["currently"]["summary"]

    if forecast["minutely"]  # sometimes this is missing from the response.  I don't know why
      forecast_next_desc   = forecast["minutely"]["summary"]
      forecast_next_icon   = forecast["minutely"]["icon"]
    else
      puts "Did not get minutely forecast data again"
      forecast_next_desc   = "No data"
      forecast_next_icon   = ""
    end

    forecast_later_desc    = forecast["hourly"]["summary"]
    forecast_later_icon    = forecast["hourly"]["icon"]

    {
      current_temp: "#{forecast_current_temp}&deg;",
      current_icon: "#{forecast_current_icon}",
      current_desc: "#{forecast_current_desc}",
      apparent_temp: "Feels Like #{forecast_apparent_temp}&deg;",
      next_icon: "#{forecast_next_icon}",
      next_desc: "#{forecast_next_desc}",
      later_icon: "#{forecast_later_icon}",
      later_desc: "#{forecast_later_desc}"
    }
  end
end
