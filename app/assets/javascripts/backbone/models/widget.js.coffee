class EarlyWord.Models.Widget extends Backbone.Model
  paramRoot: 'widget'

  defaults:
    json: null
    zip_code: null
    location: 'Processing'
    temperature: 'Processing'

class EarlyWord.Collections.WidgetsCollection extends Backbone.Collection
  model: EarlyWord.Models.Widget
  url: '/widgets'
