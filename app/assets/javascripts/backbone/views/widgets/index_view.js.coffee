EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.IndexView extends Backbone.View
  template: JST["backbone/templates/widgets/index"]

  el: '#custom-widgets'

  initialize: () ->
                @options.widgets.bind('reset', @addAll)
                @options.widgets.bind('all', @render)
                @on('newWidget', @newWidget)

  addAll: () =>
            @options.widgets.each(@addOne)

  addOne: (widget) =>
            view = new EarlyWord.Views.Widgets.WidgetView({ model: widget })
            @$el.append(view.render().el)

  addButtons: (numOfWidgets) =>
                newButton = []
                newButton.push(new EarlyWord.Views.Widgets.NewButtonView({parent: this})) for [1..numOfWidgets]
                index = 0
                _.each newButton, (button) =>
                                      index += 1
                                      if index is numOfWidgets
                                        @$el.append button.render('last').el
                                      else
                                        @$el.append button.render().el
                                      return


  render: =>
            console.log('rendering')
            $(@el).html(@template(widgets: @options.widgets.toJSON()))
            @addAll()

            numOfWidgets = (5 - @options.widgets.length)
            @addButtons(numOfWidgets)
            return this

  newWidget: (button)->
               console.log button
               @options.widgets.add({id: 2, location: 'New York', temperature: '97'})