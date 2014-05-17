EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.NewButtonView extends Backbone.View
  template: JST["backbone/templates/widgets/new_button"]

  initialize: (options) ->
                @parent = options.parent

  events:
    'mouseover': 'toggleOpacity'
    'mouseout': 'toggleOpacity'
    'click': 'newWidget'
#    "submit #new-widget": "save"

  tagName: "div"
  className: 'col-xs-2 new-widget-buttons'

  toggleOpacity: =>
                   $(@el).toggleClass('button-hover')

  render: (klass)->
            $(@el).html(@template())
            $(@el).addClass('last') if klass
            #            this.$("form").backboneLink(@model)

            return this

  newWidget: ->
               console.log('was clicked')
               @parent.trigger('newWidget', @)


