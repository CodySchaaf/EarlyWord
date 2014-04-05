# Needed for rails 4 due to turbolinks. This allows google analytics to work without page loads.
$(document).on 'page:change', ->
	if window._gaq?
		_gaq.push ['_trackPageview']
	else if window.pageTracker?
		pageTracker._trackPageview()