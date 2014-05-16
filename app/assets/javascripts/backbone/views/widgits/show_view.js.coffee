EarlyWord.Views.Widgits ||= {}

class EarlyWord.Views.Widgits.ShowView extends Backbone.View
  template: JST["backbone/templates/widgits/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
