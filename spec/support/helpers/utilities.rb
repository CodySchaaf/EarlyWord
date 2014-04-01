include ApplicationHelper

def get_fake_not_found_weather
	puts 'Getting get_fake_not_found_weather'
	JSON.parse(File.read(Rails.root.join('json_sample_90000.json')).chomp)
	end

def get_fake_found_weather
	puts 'Getting get_fake_found_weather'
	JSON.parse(File.read(Rails.root.join('json_sample.json')).chomp)
end