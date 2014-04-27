module WeatherLibrary
	def self.sanatize_wind_string(string)
		string.gsub(/\d+\.\d*/, 'x')
	end
end