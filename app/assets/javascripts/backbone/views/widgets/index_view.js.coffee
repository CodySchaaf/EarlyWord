EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.IndexView extends Backbone.View
  template: JST["backbone/templates/widgets/index"]

  el: '#custom-widgets'

  initialize: () ->
                @options.widgets.bind('reset', @addAll)
#                @options.widgets.bind('all', @render)
                @on('newWidget', @newWidget)

  addAll: () =>
            @options.widgets.each(@addOne)

  addOne: (widget) =>
            view = new EarlyWord.Views.Widgets.WidgetView({ model: widget })
            @$el.append(view.render().el)

  addButtons: (numOfWidgets) =>
                @options.buttons = []
                @options.buttons.push(new EarlyWord.Views.Widgets.NewButtonView({parent: this})) for [1..numOfWidgets]
                index = 0
                _.each @options.buttons, (button) =>
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
               new_widget = {id: 2, location: 'New York', temperature: '97'}
               @options.widgets.add(new_widget)
               view = new EarlyWord.Views.Widgets.WidgetView({ model: new_widget })
               @options.buttons[0].remove()
               if @$el.find('.widgets')
                  @$el.find('.widgets').after(view.render().el)
               else
                  @$el.prepend(view.render().el)