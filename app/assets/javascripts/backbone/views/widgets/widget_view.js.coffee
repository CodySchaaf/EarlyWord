EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.WidgetView extends Backbone.View
  template: JST["backbone/templates/widgets/widget"]

  events:
    "click .destroy" : "destroy"

  tagName: "div"
  className: 'col-xs-2 widgets'

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
