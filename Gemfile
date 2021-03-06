source 'https://rubygems.org'
ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1.0'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'sass', '3.2.13'
gem 'sprockets-rails', '2.1.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
	gem 'sdoc', '~> 0.4.0'
end

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


# Gems I added:
gem 'haml'

#this is for environment vars use: rails generate figaro:install
gem 'figaro', github: 'laserlemon/figaro'

# Devise for sign_up
gem 'devise'

gem 'html2haml'

gem 'simple_form'

# Transform css style sheet to inline styles for emails
gem 'roadie'

# Delayed jobs, used to schedule weekly news letter
gem 'delayed_job_active_record'

# Deamons used to run delayed_jobs
gem 'daemons'

# New relic gem for pinging
gem 'newrelic_rpm'

# For use if you dont want to add your environment variables manually to heroku everytime
# gem 'heroku_secrets', github: 'alexpeattie/heroku_secrets'
# run rake heroku:secrets RAILS_ENV=production to use
# gem 'heroku_secrets', github: 'alexpeattie/heroku_secrets'
# May need this, not sure yet:
# AWS::S3::Base.establish_connection!(
# 		:wunderground_key => ENV['WUNDERGROUND_KEY'],
# 		:devise_secret_key => ENV['DEVISE_SECRET_KEY'],
# 		:mandrill_username => ENV['MANDRILL_USERNAME'],
# 		:mandrill_apikey => ENV['MANDRILL_APIKEY'],
# 		:new_relic_license_key => ENV['NEW_RELIC_LICENSE_KEY'],
# 		:secret_key_base => ENV['SECRET_TOKEN'],
# )

# For logentries error logger
# After setting up use
# level specific methods like 'info', 'warn', 'debug'.
# Rails.logger.warn("Look at me, I'm a warning")
gem 'le'

gem 'font-awesome-rails'

# gem 'weather-icons-rails', '~> 0.0.1.1' ,git: 'git://github.com/CodySchaaf/weather-icons-rails.git'
# gem 'weather-icons-rails', :path => '../weather-icons-rails'
gem 'weather-icons-rails'

gem 'doppler', path: './lib/gems/doppler'

group :development do
	# used as preloader
	gem 'spring'
	# sprockets better errors in case i decide to use it later
	gem 'sprockets_better_errors'
	gem 'better_errors'
	gem 'binding_of_caller'
	gem 'quiet_assets'
	gem 'meta_request'
end

gem 'rails_12factor', group: :production

gem 'typhoeus'

group :development, :test do
	gem 'irbtools-more', require: 'binding.repl'
	gem 'terminal-notifier'
	gem 'rspec-rails'
	gem 'guard-rspec'
	gem 'launchy'
	gem 'spork-rails'
	gem 'guard-spork'
	gem 'childprocess'
	gem 'should_not'
	gem 'fuubar'
	# Needs to be in here now for email testing in rails 4.1
	gem 'factory_girl_rails'
end

group :test do
	gem 'database_cleaner', github: 'bmabey/database_cleaner'
	gem 'selenium-webdriver'
	gem 'capybara'
	gem 'growl'
	gem 'timecop'
end