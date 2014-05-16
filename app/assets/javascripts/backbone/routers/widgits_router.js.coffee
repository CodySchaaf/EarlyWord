#class EarlyWord.Routers.WidgitsRouter extends Backbone.Router
#  initialize: (options) ->
#    @widgits = new EarlyWord.Collections.WidgitsCollection()
#    @widgits.reset options.widgits
#
#  routes:
#    "new"      : "newWidgit"
#    "index"    : "index"
#    ":id/edit" : "edit"
#    ":id"      : "show"
#    ".*"        : "index"
#
#  newWidgit: ->
#    @view = new EarlyWord.Views.Widgits.NewView(collection: @widgits)
#    $("#widgits").html(@view.render().el)
#
#  index: ->
#    @view = new EarlyWord.Views.Widgits.IndexView(widgits: @widgits)
#    $("#widgits").html(@view.render().el)
#
#  show: (id) ->
#    widgit = @widgits.get(id)
#
#    @view = new EarlyWord.Views.Widgits.ShowView(model: widgit)
#    $("#widgits").html(@view.render().el)
#
#  edit: (id) ->
#    widgit = @widgits.get(id)
#
#    @view = new EarlyWord.Views.Widgits.EditView(model: widgit)
#    $("#widgits").html(@view.render().el)
