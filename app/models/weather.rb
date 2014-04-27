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

		weather = stored_weather ? stored_weather.update_json! : Weather.create_new(new_weather)

		weather
	end

	def update_json!
		self.update_attributes json: Weather.get_current_weather(zip_code) unless current?
		self
	end

	def json_valid?
		!self.not_found?
	end

	def not_found?
		json['response']['error'] && json['response']['error']['description'][/No cities match your search query/]
	end

	def self.update_key_words_weather_yaml(user_weather)
		key_words = YAML::load_file(Rails.root.join('weather_key_words.yml'))
		check_for_key_word key_words, user_weather, 'weather'
		check_for_key_word key_words, user_weather, 'wind_string'
		key_words.with_indifferent_access
	end

	private

	def self.check_for_key_word(key_words, user_weather, yaml_key)
		yaml_key.eql?('wind_string') ? weather_key = WeatherLibrary.sanatize_wind_string(user_weather['current_observation'][yaml_key]) :
				weather_key = user_weather['current_observation'][yaml_key]
		unless key_words[yaml_key].has_key?(weather_key)
			key_words[yaml_key][weather_key] = {day: 'NEEDS IMAGE ASSIGNMENT', night: 'NEEDS IMAGE ASSIGNMENT', neutral: 'NEEDS IMAGE ASSIGNMENT'}.stringify_keys
			File.open(Rails.root.join('weather_key_words.yml'), 'w') {|f| f.write key_words.to_yaml }
		end
	end

	def self.create_new(new_weather)
		self.create({ zip_code: new_weather.zip_code, json: self.get_current_weather(new_weather.zip_code) })
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
