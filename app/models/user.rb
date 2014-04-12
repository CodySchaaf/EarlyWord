class User < ActiveRecord::Base
  belongs_to :weather
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :set_forecast_schedule
  before_save { self.email.downcase! }
  after_create :send_sign_up_email
  after_create :schedule_forecast_email

  def update_forecast_schedule(new_time=nil)
	  logger.debug('We are now updating the forecast schedule')
	  if new_time
		  self.update_attribute(:forecast_scheduled_at, new_time.tomorrow)
	  else
		  self.update_attribute(:forecast_scheduled_at, self.forecast_scheduled_at.tomorrow)
	  end
  end

  def schedule_forecast_email
	  logger.debug("We are now scheduling the forecast job for user: #{id}")
	  if self.weather_id && self.forecast_scheduled_at
		  Delayed::Job.enqueue(ForecastJob.new(self), :run_at => self.forecast_scheduled_at)
		  logger.debug("We have scheduled the forecast job for user: #{id}")
	  end
  end

  def zip_code
		Weather.find(weather_id).zip_code
  end

	private

		def send_sign_up_email
			logger.debug('We are now doing send_sign_up_email.')
			ForecastMailer.delay.sign_up_email(self)
		end

    def set_forecast_schedule
	    #TODO update this and move to correct place
	    #Do not do this!
	    Time.zone = 'Pacific Time (US & Canada)'
			self.forecast_scheduled_at = Time.current.midnight.since(6.hours)
    end

end
