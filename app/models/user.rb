class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :weather
  before_create :set_forecast_schedule
  after_create :send_sign_up_email
  after_create :schedule_forecast_email

	private

		def send_sign_up_email
			logger.debug('We are now doing send_sign_up_email.')
			Forecast.send_sign_up_email(self).deliver!
		end

    def set_forecast_schedule
			self.update_attribute(:forecast_scheduled_at, Time.parse('02:00:00 AM').tomorrow)
    end

    def update_forecast_schedule(new_time=nil)
			if new_time
				self.update_attribute(:forecast_scheduled_at, self.new_time.tomorrow)
			else
	      self.update_attribute(:forecast_scheduled_at, self.forecast_scheduled_at.tomorrow)
			end
    end

		def schedule_forecast_email
			if self.zip_code_id && self.forecast_scheduled_at
				Delayed::Job.enqueue(ForecastJob.new(self), :run_at => self.forecast_scheduled_at)
			end
		end

end
