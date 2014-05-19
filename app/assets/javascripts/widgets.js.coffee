# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(->
    notSignedInEle = $('.not-singed-in')
    if notSignedInEle
      notSignedInEle.filter('.new-widget-buttons').popover
        html: true
        offset: 5
        placement: "right"
        title: ->
                 return $('#popover-head').html()
        content: ->
                   return $('#popover-content').html()

      $("body").on "click", (e) ->
                              $('[data-toggle="popover"]').each ->
                                                                  #the 'is' for buttons that trigger popups
                                                                  #the 'has' for icons within a button that triggers a popup
                                                                  $(this).popover "hide"  if not $(this).is(e.target) and $(this).has(e.target).length is 0 and $(".popover").has(e.target).length is 0
 )