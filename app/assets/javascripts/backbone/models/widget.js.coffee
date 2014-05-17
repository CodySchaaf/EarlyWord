class EarlyWord.Models.Widget extends Backbone.Model
  paramRoot: 'widget'

  defaults:
    location: null
    temperature: null

class EarlyWord.Collections.WidgetsCollection extends Backbone.Collection
  model: EarlyWord.Models.Widget
  url: '/widgets'
