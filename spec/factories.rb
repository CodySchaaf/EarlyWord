FactoryGirl.define do
	after(:build) { |object| puts "Built #{object}" }
	sequence(:zip_code, '10001') { |n| n}

	factory :user do
		association :weather
		sequence(:name)  { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com"}
		password "foobaring"
		password_confirmation "foobaring"

		#initialize_with { new(attributes) }
	end

	factory :weather, aliases: [:zip_code] do
		zip_code { generate :zip_code }
		json ''

		after :create do |weather|
			weather.json = JSON.parse(File.read(Rails.root.join('json_sample.json')).chomp)
		end

		trait :not_found do
			after :create do |weather|
				weather.json = JSON.parse(File.read(Rails.root.join('json_sample_90000.json')).chomp)
			end
		end
		#initialize_with { new(attributes) }
	end

end