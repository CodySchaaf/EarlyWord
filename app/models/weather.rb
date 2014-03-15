class Weather < ActiveRecord::Base
	before_save :set_updated_at
	serialize :json, JSON

	validates :zip_code, length: { is: 5 }, presence: true, format: {with: /\d{5}/}
	has_many :users

	def current?
		updated_at > 1.hour.ago
	end

	def self.get_weather(new_weather)
		stored_weather = Weather.find_by_zip_code new_weather.zip_code

		stored_weather ? stored_weather.update_json :
				Weather.create({ zip_code: zip_code, json: get_current_weather(zip_code) })
	end

	#def self.get_weather_for_user(user)
	#
	#end

	private

		def get_current_weather(zip_code)
			response = Typhoeus.get "http://api.wunderground.com/api/#{ENV['WUNDER_GROUND_KEY']}/forecast/conditions/hourly/q/#{zip_code}.json", followlocation: true
			JSON.parse response.body
		end

		def self.update_json
			self.update_attribute(:json, get_current_weather(zip_code)) unless current?
		end

		def weather_params
			params.require(:weather).permit(:zip_code)
		end

		def set_updated_at
			self.updated_at = Time.now
		end

end
