#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

ENTER_KEY = 13
ESC_KEY = 27

window.EarlyWord =
	Models: {}
	Collections: {}
	Routers: {}
	Views: {}
	init: (widgets)->
		window.router = new EarlyWord.Routers.WidgetsRouter({ widgets: widgets})
		Backbone.history.start()