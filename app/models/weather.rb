class Weather < ActiveRecord::Base
	#before_save :set_updated_at
	serialize :json, JSON

	validates :zip_code, length: { is: 5 }, presence: true, format: {with: /\d{5}/}
	has_many :users

	def current?
		updated_at > 1.hour.ago
	end

	def self.get_weather(new_weather)
		Doppler.fetch_weather(new_weather)
	end

	def update_json!
		self.update_attributes json: Doppler.get_current_weather(zip_code) unless current?
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
		check_for_key_word key_words, user_weather.weather_in_words, 'weather'
		check_for_key_word key_words, user_weather.sanatized_wind_in_words, 'wind_string'
		key_words.with_indifferent_access
	end

	private

	def self.check_for_key_word(key_words, yaml_key, type)
		unless key_words[type].has_key?(yaml_key)
			key_words[type][yaml_key] = {day: 'NEEDS IMAGE ASSIGNMENT', night: 'NEEDS IMAGE ASSIGNMENT', neutral: 'NEEDS IMAGE ASSIGNMENT'}.stringify_keys
			File.open(Rails.root.join('weather_key_words.yml'), 'w') {|f| f.write key_words.to_yaml }
		end
	end

	def self.create_new(zip_code)
		self.create({ zip_code: zip_code, json: Doppler.get_current_weather(zip_code) })
	end

end
