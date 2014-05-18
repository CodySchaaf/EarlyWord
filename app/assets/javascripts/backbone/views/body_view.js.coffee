EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.BodyView extends Backbone.View
  el: 'body'

  initialize: ->
                console.log('initialized big view')

  events:
    "click": "buttonClick"


  buttonClick: ->
                 console.log('Big View Says Hi')
                 Backbone.trigger('body:click')