class WidgetsController < ApplicationController

	WIDGETS = %w(widget_1 widget_2 widget_3 widget_4 widget_5)

	def create
		logger.debug('we made it guys')
		if signed_in?
			weather = Weather.get_weather Weather.new(widget_params)
			@widget = WidgetResponse.new(weather)
			empty_widget = WIDGETS.find { |widget| current_user[widget.to_sym].nil? }

			if @widget.location[/Not Found/]
				@widget.location = 'Not Found'
				@widget.id =  0
			elsif empty_widget && current_user.existing_widget?(@widget.id)
				@widget.location = 'Duplicate!'
				@widget.id =  0
			elsif empty_widget
				current_user.update_attributes!(empty_widget.to_sym => @widget.id)
			else
				return render json: 'Already Have 5 Widgets', status: :unprocessable_entity
			end

			render :show
		else
			format.json { render json: 'Not Signed In', status: :unprocessable_entity }
		end
	end

	def show
	end

	private

		def widget_params
			params.require(:widget).permit(:zip_code)
		end
end
