# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
EarlyWord::Application.initialize!

Rails.logger = Le.new(Rails.application.secrets.logentries_logger_key, debug: !!Rails.env.development?)