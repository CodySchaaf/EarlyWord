EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.IndexView extends Backbone.View
  template: JST["backbone/templates/widgets/index"]

  el: '#custom-widgets'

  initialize: (options) ->
                console.log('index initialized')
                @options = options
#                @options.widgets.fetch({reset: true})
                @listenTo(@options.widgets, 'reset', @addAll)
                @listenTo(@options.widgets, 'add', @removeButton)
#                @options.widgets.bind('all', @render)
                @on('newWidget', @newWidget)

  addAll: () =>
            console.log(@options)
            console.log(@options.widgets)
            console.log(@options.widgets.models)
            console.log(@options.widgets.models)
            @options.widgets.models.each(@addOne)

  addOne: (widget) =>
            view = new EarlyWord.Views.Widgets.WidgetView({ model: widget })
            @$el.append(view.render(@options).el)

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

  removeButton: =>
                  @options.buttons.shift().remove()

  render: =>
            console.log('rendering')
#            $(@el).html(@template(widgets: @options.widgets.toJSON()))
            @addAll()

            numOfWidgets = (5 - @options.widgets.length)
            @addButtons(numOfWidgets)
            return this

  newWidget: (button)->
               new_widget = {zip_code: button.$input.val().trim()}
               created_widget = @options.widgets.create(new_widget,{error: (model,response) -> console.log(response.responseText)})
               button.$input.val('')
               view = new EarlyWord.Views.Widgets.WidgetView({ model: created_widget })
               console.log(button)
               button.toggleClasses(button.$el)
               if @$el.find('.widgets')
                  @$el.find('.widgets').last().after(view.render(@options).el)
               else
                  @$el.prepend(view.render().el)