include ApplicationHelper

def get_fake_weather
	puts 'in faker'
	JSON.parse(File.read(Rails.root.join('json_sample_90000.json')).chomp)
end