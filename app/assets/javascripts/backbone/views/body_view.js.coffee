EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.BodyView extends Backbone.View
  el: 'body'

  events:
    "click": "buttonClick"


  buttonClick: ->
                 Backbone.trigger('body:click')