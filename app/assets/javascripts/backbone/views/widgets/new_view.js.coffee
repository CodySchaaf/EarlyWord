EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.NewView extends Backbone.View
  template: JST["backbone/templates/widgets/new"]

  events:
    "submit #new-widget": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (widget) =>
        @model = widget
        window.location.hash = "/#{@model.id}"

      error: (widget, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
