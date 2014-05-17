#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.EarlyWord =
	Models: {}
	Collections: {}
	Routers: {}
	Views: {}
	init: (widgets)->
		window.router = new EarlyWord.Routers.WidgetsRouter({ widgets: widgets})
		Backbone.history.start()