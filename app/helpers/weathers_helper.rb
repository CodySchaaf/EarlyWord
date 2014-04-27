module WeathersHelper

	def time_of_day(response)
		sunrise_hash = response[:moon_phase][:sunrise]
		sunset_hash = response[:moon_phase][:sunset]
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

	def get_weather_icon(response, key_words)
		current_weather = response[:current_observation][:weather]

		wi_icon("#{key_words['weather'][current_weather][time_of_day(response)]} lg")
	end

	def get_wind_icon(response, key_words)
		sanitized_wind_string = WeatherLibrary.sanatize_wind_string(response[:current_observation][:wind_string])

		wi_icon("#{key_words['wind_string'][sanitized_wind_string][time_of_day(response)]} lg")
	end

	def format_wind(response)
		wind_match = response[:current_observation][:wind_string].match(/From the (\w+) at ([\d\.]+) MPH Gusting to ([\d\.]+) MPH/)
		unless wind_match
			return 'New Format Found'
		end
		# "#{wind_match[2]} MPH, #{wind_match[1]}. Gusts upto #{wind_match[3]} MPH"
		"#{wind_match[2]} MPH, #{wind_match[1]}"
	end
end
