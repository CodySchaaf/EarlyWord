module ForecastMailersHelper

	def last? time
		Time.zone = 'Pacific Time (US & Canada)'
		now = Time.current
		hour = Time.parse(time)
		if hour < now
			true
		else
			false
		end
	end
end
