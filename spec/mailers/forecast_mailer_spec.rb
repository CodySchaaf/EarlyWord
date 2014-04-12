require 'spec_helper'
include ForecastMailersHelper

describe ForecastMailer do
	let(:weather) { create :weather }
	let!(:user) { create :user, weather: weather }
	before do
		allow(Weather).to receive(:get_current_weather).and_return(get_fake_found_weather)
		weather.update_attribute :json, get_fake_found_weather
		allow(Weather).to receive(:find) { weather }
		ActionMailer::Base.deliveries.clear
	end
	subject{ ForecastMailer.forecast_email(user) }

	describe 'forecast email' do
		it 'sends the email' do
			expect(subject.to).to eq([user.email])
		end

		it 'creates a an email with a weather specific subject' do
			expect(subject.subject).to eq('Good Morning, here is your daily forecast!')
		end

	end

	describe 'sends updated weather when weather in db is not current' do
		it 'updates stale weather data with updated info' do
			expect(weather.updated_at).to be_within(1.minute).of(Time.current)
			Timecop.travel(2.days) do
				expect(weather.updated_at).to be_within(1.hour).of(2.days.ago)
				subject
				expect(weather.updated_at).to be_within(1.second).of(Time.current)
			end
		end
	end

end
