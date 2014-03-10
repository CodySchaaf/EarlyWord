class Weather < ActiveRecord::Base
	before_save :set_updated_at
	serialize :json, JSON

	validates :zip_code, length: { is: 5 }

	def current?
		updated_at > 1.hour.ago
	end

	def self.get_weather(zip_code)
		stored_weather = Weather.find_by_zip_code zip_code
		if stored_weather && stored_weather.current?
			parsed_json = stored_weather.json
			puts "Found in db: #{stored_weather.json.class}"
		else
			response = Typhoeus.get "http://api.wunderground.com/api/#{ENV['WUNDER_GROUND_KEY']}/forecast/conditions/hourly/q/#{zip_code}.json", followlocation: true
			parsed_json = JSON.parse response.body
			Weather.create zip_code: zip_code, json: parsed_json
			puts  'Created new in db'
		end
		parsed_json
	end

	private

		def weather_params
			params.require(:weather).permit(:zip_code)
		end

		def set_updated_at
			self.updated_at = Time.now
		end

end
