class EarlyWord.Models.Widgit extends Backbone.Model
  paramRoot: 'widgit'

  defaults:
    location: null
    temperature: null

class EarlyWord.Collections.WidgitsCollection extends Backbone.Collection
  model: EarlyWord.Models.Widgit
  url: '/widgits'
