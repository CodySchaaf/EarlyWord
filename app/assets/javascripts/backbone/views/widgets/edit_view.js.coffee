EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.EditView extends Backbone.View
  template : JST["backbone/templates/widgets/edit"]

  events :
    "submit #edit-widget" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (widget) =>
        @model = widget
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
