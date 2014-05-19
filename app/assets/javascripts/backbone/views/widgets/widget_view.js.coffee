EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.WidgetView extends Backbone.View
  template: JST["backbone/templates/widgets/widget"]

  events:
    "click .destroy": "destroy"

  tagName: "div"
  className: 'col-xs-2 widgets'

  initialize: ->
                @listenTo(@model, 'change', @render);

  destroy: () ->
             @model.destroy()
             @remove()
             return false

  render: (options)->
            $(@el).html(@template(@model.toJSON()))
            $(@el).addClass('last') if options.widgets and options.widgets.length is 5
            return this
