FactoryGirl.define do
	after(:build) { |object| puts "Built #{object}" }


	factory :user do
		sequence(:name)  { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com"}
		password "foobar"
		password_confirmation "foobar"

	end

	factory :zip_code, class: Weather do
		zip_code "94116"

		factory :weather do
			json JSON.parse(File.read(Rails.root.join('json_sample.json')).chomp)
		end
	end
end