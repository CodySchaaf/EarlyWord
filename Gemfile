source 'https://rubygems.org'
ruby '2.1.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass', '~> 3.1.1'

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
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
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
gem 'figaro'

# Devise for sign_up
gem 'devise'

gem 'html2haml'

gem 'simple_form'

group :development do
	gem "better_errors"
	gem "binding_of_caller"
	gem 'quiet_assets'
end

gem 'rails_12factor', group: :production

#gem 'barometer'
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
end

group :test do
	gem 'database_cleaner', github: 'bmabey/database_cleaner'
	gem 'selenium-webdriver'
	gem 'capybara'
	gem 'growl'
	gem 'factory_girl_rails'
end