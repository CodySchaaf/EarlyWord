require "spec_helper"

describe ForecastJob do
	let(:weather) { create :weather }
	let!(:user) { create :user, weather: weather }
	before do
		allow(Weather).to receive(:get_current_weather).and_return(get_fake_found_weather)
		weather.update_attribute :json, get_fake_found_weather
		allow(Weather).to receive(:find) { weather }
		ActionMailer::Base.deliveries.clear
	end
	subject{ Delayed::Worker.new.work_off }
	describe 'performing delayed job' do

		it 'removes and addes a new job to the queue after removing old job' do
			expect(ActionMailer::Base.deliveries.count).to eq(0)
			expect(Delayed::Job.count).to eq(1)
			expect{subject}.to_not change(Delayed::Job, :count)
			expect(Delayed::Job.count).to eq(1)
			expect(ActionMailer::Base.deliveries.count).to eq(1)
		end

		it 'updates the scheduled time to tomorrow' do
			expect {
				subject
			}.to change {
				Delayed::Job.last.run_at
			}.from(
					     Time.now.midnight.since(2.hours)
			     ).to(
					     Time.now.tomorrow.midnight.since(2.hours)
			     )
		end

		it 'returns with one success and no failures' do
			expect(subject).to eq([1, 0])
		end

		describe 'forecast email' do
			before {subject}
			it 'sends the email' do
				expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
			end

			it 'creates a an email with a weather specific subject' do
				expect(ActionMailer::Base.deliveries.last.subject).to eq('Good Morning, here is your daily forecast!')
			end

		end
	end
end