EarlyWord.Views.Widgits ||= {}

class EarlyWord.Views.Widgits.EditView extends Backbone.View
  template : JST["backbone/templates/widgits/edit"]

  events :
    "submit #edit-widgit" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (widgit) =>
        @model = widgit
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
