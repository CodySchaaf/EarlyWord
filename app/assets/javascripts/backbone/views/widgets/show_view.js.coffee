EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.ShowView extends Backbone.View

	template: JST["backbone/templates/widgets/show"]

	render: ->
		$(@el).html(@template(@model.toJSON({})))
		return this
