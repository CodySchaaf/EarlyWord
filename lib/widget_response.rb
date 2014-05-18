class WidgetResponse
	include ActionView::Helpers::TagHelper
	attr_accessor :widget, :id, :json

	RESPONSE_DATA = {
			location: [:current_observation, :display_location, :city],
			temp_f:           [:current_observation, :temp_f],
	}

	def initialize(widget)
		@widget = widget
		@json = widget.json.with_indifferent_access
		@id = widget.id
		RESPONSE_DATA.each do |method, json_key|
			self.class.send(:attr_accessor, method)
			self.send "#{method}=", json_key.inject(json, :[])
		end
	end

	def degrees_f
		"#{temp_f} &deg; F"
	end

	def to_json
		# {id: widget.id, temperature: degrees_f, location: location}.to_json.html_safe
		{id: widget.id, temperature: degrees_f, location: location}
	end

end