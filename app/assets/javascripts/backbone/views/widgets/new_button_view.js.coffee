EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.NewButtonView extends Backbone.View
  template: JST["backbone/templates/widgets/new_button"]

  initialize: (options) ->
                @parent = options.parent
                @$input = @$('#widget_zip_code')
                console.log(Backbone)
                @listenTo(Backbone, 'body:click', @hideForm);


  events:
    'mouseover': 'toggleOpacity'
    'mouseout': 'toggleOpacity'
    'keypress': 'newWidget'
    'click': 'showForm'
#    "submit #new-widget": "save"

  tagName: "div"
  className: 'col-xs-2 new-widget-buttons icon-view'

  toggleOpacity: =>
                   $(@el).toggleClass('button-hover')

  render: (klass)->
            $(@el).html(@template())
            $(@el).addClass('last') if klass
            #            this.$("form").backboneLink(@model)

            return this

  showForm: ->
              return if @$el.hasClass('form-view')

  hideForm: ->
              return if not @$el.hasClass('form-view')
              @toggleClasses

  newWidget: (event) ->
               return if @$el.hasClass('icon-view')
               return if event.which isnt ENTER_KEY or event.which isnt ESC_KEY or not @$input.val().trim()
               if event.which is ESC_KEY
                  @toggleClasses
                  return
               @parent.trigger('newWidget', @)


  toggleClasses: ->
                   @$el.toggleClass('icon-view')
                   @$el.toggleClass('form-view')




