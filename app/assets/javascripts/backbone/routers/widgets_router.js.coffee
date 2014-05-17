class EarlyWord.Routers.WidgetsRouter extends Backbone.Router
  initialize: (options) ->
                console.log options
                @widgets = new EarlyWord.Collections.WidgetsCollection()
                @widgets.reset options.widgets

  routes:
    "new": "newWidget"
    "index": "index"
    ":id/edit": "edit"
    ":id": "show"
    ".*": "index"

  newWidget: ->
               @view = new EarlyWord.Views.Widgets.NewView(collection: @widgets)
               $("#widgets").html(@view.render().el)

  index: ->
           @view = new EarlyWord.Views.Widgets.IndexView(widgets: @widgets)
           $("#widgets").html(@view.render().el)

  show: (id) ->
          console.log id
          console.log @widgets
          widget = @widgets.get(id)
          console.log widget
          @view = new EarlyWord.Views.Widgets.ShowView(model: widget)
          console.log @view
          $("#widgets").html(@view.render().el)

  edit: (id) ->
          widget = @widgets.get(id)

          @view = new EarlyWord.Views.Widgets.EditView(model: widget)
          $("#widgets").html(@view.render().el)
