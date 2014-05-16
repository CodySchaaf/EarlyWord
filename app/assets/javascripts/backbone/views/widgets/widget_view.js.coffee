EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.WidgetView extends Backbone.View
  template: JST["backbone/templates/widgets/widget"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    console.log @model
		$(@el).html(@template(@model.toJSON() ))
		@
