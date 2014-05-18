require "doppler/version"

module Doppler
	def self.fetch_weather(new_weather)
		klass = new_weather.class
		stored_weather = klass.find_by(zip_code: new_weather.zip_code)

		weather = stored_weather ? stored_weather.update_json! : klass.create_new(new_weather.zip_code)

		weather
	end

	def self.get_current_weather(zip_code)
		raise 'Big Problem Should not be in here during test' if ENV['RAILS_ENV'] == 'test'
		response = Typhoeus.get "http://api.wunderground.com/api/#{Rails.application.secrets.wunderground_key}/forecast10day/conditions/hourly/astronomy/alerts/q/#{zip_code}.json", followlocation: true
		if ENV['RAILS_ENV'] == 'development' && response.response_code.to_s == '504'
			raise 'Big Problem Should unless it is development' if ENV['RAILS_ENV'] == 'production'
			logger.debug('An Error Occurred with wunderground, using lame data.')
			JSON.parse(File.read(Rails.root.join('json_sample.json')).chomp)
		else
			JSON.parse response.body
		end
	end
end
