require 'weather-icons-rails'

class WeatherResponse
	include WeatherIcons::Rails::IconHelpers
	include ActionView::Helpers::TagHelper
	attr_accessor :json

	RESPONSE_DATA = {
			weather_in_words: [:current_observation, :weather],
			temp_f:           [:current_observation, :temp_f],
			zip_code:         [:current_observation, :display_location, :zip],
			sunrise:          [:moon_phase, :sunrise],
			sunset:           [:moon_phase, :sunset],
	    wind_in_words:    [:current_observation, :wind_string],
			weather_now_long: [:forecast, :txt_forecast, :forecastday, 0, :fcttext],
			hourly_forecast:  [:hourly_forecast]
	}

	def initialize(json)
		# @json = json
		RESPONSE_DATA.each do |method, json_key|
			self.class.send(:attr_accessor, method)
			self.send "#{method}=", json_key.inject(json, :[])
		end
	end

	def degrees_f
		"#{temp_f} &deg; F"
	end

	def sanatized_wind_in_words
		wind_in_words.gsub(/\d+\.\d*/, 'x')
	end

	def formatted_wind
		regexp_for_gusts = /From the (\w+) at ([\d\.]+) MPH Gusting to ([\d\.]+) MPH/
		wind_in_words_match = wind_in_words.match(/#{regexp_for_gusts}/)
		wind_in_words_match ? "#{wind_in_words_match[2]} MPH, #{wind_in_words_match[1]}" : wind_in_words
	end

	def get_hourly_forecast
		hourly_forecast.first(8).each_with_index.map do |hour,index|
			next if index.odd?
			"#{hour[:FCTTIME][:civil]}: #{hour[:temp][:english]} &deg; F"
		end.compact!
	end

	def get_wind_icon
		key_words = Weather.update_key_words_weather_yaml self
		wi_icon("#{key_words['wind_string'][sanatized_wind_in_words][time_of_day]} lg")
	end

	def get_weather_icon
		key_words = Weather.update_key_words_weather_yaml self
		wi_icon("#{key_words['weather'][weather_in_words][time_of_day]} lg")
	end

	def time_of_day
		sunrise_hash = sunrise
		sunset_hash = sunset
		sunrise_time = get_time_of_event_from_hash sunrise_hash
		sunset_time = get_time_of_event_from_hash sunset_hash
		if Time.zone.now.between?(sunrise_time+1.hour,sunset_time-1.hour)
			:day
		elsif Time.zone.now.between?(sunset_time+1.hour,sunrise_time-1.hour)
			:night
		else
			:neutral
		end
	end

	def get_time_of_event_from_hash(hash)
		Time.zone.now.at_beginning_of_day + hash[:hour].to_i.hours + hash[:minute].to_i.minutes
	end
end