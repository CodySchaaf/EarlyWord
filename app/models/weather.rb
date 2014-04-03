class Weather < ActiveRecord::Base
	#before_save :set_updated_at
	serialize :json, JSON

	validates :zip_code, length: { is: 5 }, presence: true, format: {with: /\d{5}/}
	has_many :users

	def current?
		updated_at > 1.hour.ago
	end

	def self.get_weather(new_weather)
		stored_weather = Weather.find_by_zip_code(new_weather.zip_code)

		weather = stored_weather ? stored_weather.update_json : Weather.create_new(new_weather)

		weather
	end

	def update_json
		self.update_attributes json: Weather.get_current_weather(zip_code) unless current?
		self
	end

	def json_valid?
		!self.not_found?
	end

	def not_found?
		json['response']['error'] && json['response']['error']['description'][/No cities match your search query/]
	end

	private

	def self.create_new(new_weather)
		self.create({ zip_code: new_weather.zip_code, json: self.get_current_weather(new_weather.zip_code) })
	end

	def self.get_current_weather(zip_code)
		raise 'Big Problem Should not be in here during test' if ENV['RAILS_ENV'] == 'test'
		response = Typhoeus.get "http://api.wunderground.com/api/#{ENV['WUNDER_GROUND_KEY']}/forecast/conditions/hourly/q/#{zip_code}.json", followlocation: true
		if ENV['RAILS_ENV'] == 'development' && response.response_code.to_s == '504'
			raise 'Big Problem Should unless it is development' if ENV['RAILS_ENV'] == 'production'
			logger.debug('An Error Occurred with wunderground, using lame data.')
			JSON.parse(File.read(Rails.root.join('json_sample.json')).chomp)
		else
			JSON.parse response.body
		end
	end
end
