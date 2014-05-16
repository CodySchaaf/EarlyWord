#EarlyWord.Views.Widgets ||= {}
#
#class EarlyWord.Views.Widgets.IndexView extends Backbone.View
#  template: JST["backbone/templates/widgets/index"]
#
#  initialize: () ->
#    @options.widgets.bind('reset', @addAll)
#
#  addAll: () =>
#    @options.widgets.each(@addOne)
#
#  addOne: (widget) =>
##    view = new EarlyWord.Views.Widgets.WidgetView({model : widget})
##    @$("tbody").append(view.render().el)
#
#  render: =>
#    $(@el).html(@template(widgets: @options.widgets.toJSON() ))
#    @addAll()
#
#    return this
