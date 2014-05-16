#EarlyWord.Views.Widgits ||= {}
#
#class EarlyWord.Views.Widgits.IndexView extends Backbone.View
#  template: JST["backbone/templates/widgits/index"]
#
#  initialize: () ->
#    @options.widgits.bind('reset', @addAll)
#
#  addAll: () =>
#    @options.widgits.each(@addOne)
#
#  addOne: (widgit) =>
#    view = new EarlyWord.Views.Widgits.WidgitView({model : widgit})
#    @$("tbody").append(view.render().el)
#
#  render: =>
#    $(@el).html(@template(widgits: @options.widgits.toJSON() ))
#    @addAll()
#
#    return this
