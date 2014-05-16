#EarlyWord.Views.Widgits ||= {}
#
#class EarlyWord.Views.Widgits.NewView extends Backbone.View
#  template: JST["backbone/templates/widgits/new"]
#
#  events:
#    "submit #new-widgit": "save"
#
#  constructor: (options) ->
#    super(options)
#    @model = new @collection.model()
#
#    @model.bind("change:errors", () =>
#      this.render()
#    )
#
#  save: (e) ->
#    e.preventDefault()
#    e.stopPropagation()
#
#    @model.unset("errors")
#
#    @collection.create(@model.toJSON(),
#      success: (widgit) =>
#        @model = widgit
#        window.location.hash = "/#{@model.id}"
#
#      error: (widgit, jqXHR) =>
#        @model.set({errors: $.parseJSON(jqXHR.responseText)})
#    )
#
#  render: ->
#    $(@el).html(@template(@model.toJSON() ))
#
#    this.$("form").backboneLink(@model)
#
#    return this
