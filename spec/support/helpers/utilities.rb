include ApplicationHelper

def get_fake_weather
	JSON.parse(File.read(Rails.root.join('json_sample_90000.json')).chomp)
end