class Weather < ActiveRecord::Base
	before_save :set_updated_at
	serialize :json, JSON

	validates :zip_code, length: { is: 5 }, presence: true, format: {with: /\d{5}/}
	has_many :users

	def current?
		updated_at > 1.hour.ago
	end

	def self.get_weather(new_weather)
		stored_weather = Weather.find_by_zip_code new_weather['zip_code']

		stored_weather ? stored_weather.update_json :
				Weather.create_new(new_weather)
	end

	def update_json
		update_attribute(:json, get_current_weather(zip_code)) unless self.current?
		self
	end

	#def self.get_weather_for_user(user)
	#
	#end

	private

		def self.create_new(new_weather)
			self.create({ zip_code: new_weather['zip_code'], json: self.get_current_weather(new_weather['zip_code']) })
		end

		def self.get_current_weather(zip_code)
			response = Typhoeus.get "http://api.wunderground.com/api/#{ENV['WUNDER_GROUND_KEY']}/forecast/conditions/hourly/q/#{zip_code}.json", followlocation: true
			JSON.parse response.body
		end

		def weather_params
			params.require(:weathers).permit(:zip_code)
		end

		def set_updated_at
			self.updated_at = Time.now
		end

end
