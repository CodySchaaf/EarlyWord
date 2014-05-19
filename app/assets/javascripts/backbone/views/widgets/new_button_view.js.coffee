EarlyWord.Views.Widgets ||= {}

class EarlyWord.Views.Widgets.NewButtonView extends Backbone.View
  template: JST["backbone/templates/widgets/new_button"]
  ENTER_KEY: 13
  ESC_KEY: 27

  initialize: (options) ->
                @parent = options.parent
                #                @$input = @$('.widget_zip_code')
                @listenTo(Backbone, 'body:click', @hideForm);


  events:
    'mouseover': 'toggleOpacity'
    'mouseout': 'toggleOpacity'
    'click': 'showForm'
    'keypress': 'newWidget'
    'keyup': 'closeInput'
    'submit form': (e) ->
                     e.preventDefault()
                     e.stopPropagation()
#    "submit #new-widget": "save"

  tagName: "div"
  className: 'col-xs-2 new-widget-buttons icon-view'

  toggleOpacity: =>
                   $(@el).toggleClass('button-hover')

  render: (klass)->
            $(@el).html(@template())
            $(@el).addClass('last') if klass
            return this

  showForm: (event) ->
              event.stopImmediatePropagation()
              return if @$el.hasClass('form-view')
              @toggleClasses(@$el)
              @$el.find('input').focus()

  hideForm: ->
              return if not @$el.hasClass('form-view')
              @toggleClasses(@$el)

  newWidget: (event) ->
               @$input = @$('.widget_zip_code')
               event.stopImmediatePropagation()
               return if @$el.hasClass('icon-view')
               if event.which is @ESC_KEY
                 @toggleClasses
                 return
               return if event.which isnt @ENTER_KEY or not (@$input.val().trim().length is 5)
               @parent.trigger('newWidget', @)

  closeInput: (event) ->
                if event.which is @ESC_KEY
                  @toggleClasses(@$el)

  toggleClasses: (button) ->
                   button.toggleClass('icon-view')
                   button.toggleClass('form-view')




