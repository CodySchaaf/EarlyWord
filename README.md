README
======

Thanks CODESHIP! 

[ ![Codeship Status for CodySchaaf/EarlyWord](https://www.codeship.io/projects/29e1bbe0-9d10-0131-853d-5efbb97d7440/status?branch=master)](https://www.codeship.io/projects/17877)

##EarlyWord

EarlyWord is a side project I have been working on. It aims to provide users with a more detailed overview of their daily 
 activities. I'm currently working on weather, using the WeatherUnderground api. I want to provide users with information 
 that can help them plan for their days, such as if they will need a coat later today. I hope to implement logic machines that
  will learn how users respond to different temperatures, and can be improved through user feedback. Currently most weather services let you know
 what the temperature outside is, but what happens when it is nice where you live, however it is pouring at work? 
  
Currently it send a daily email out to users, and offers one view of the weather of your choice. I'm almost done with a Backbone.js 
upgrade that will allow for multiple weather widgets. This will allow users to subscribe to multiple weather feeds and track their commute's 
 weather as well as travel plans and more! 
 
The app is hosted currently using Heroku, but is not yet finished. Check it out: [EarlyWord](http://earlyword.herokuapp.com/)

* Ruby version: 2.1.1

* Rails version: 4.1.0

* Database: Postgres

* Test suite: bundle exec rspec

* Services (job queues, cache servers, search engines, etc.): Delayed::Jobs sending forecast emails. Use `bundle exec rake jobs:work` to start worker.

* Deployment instructions: Using Unicorn with Foreman. To launch server run the command `foreman start`

* To use mailcatcher: Simply run gem install mailcatcher then mailcatcher to get started.

Thanks WUNDERGROUND!

![WUNDERGROUND Logo](http://icons.wxug.com/logos/images/wundergroundLogo_4c_horz.jpg)