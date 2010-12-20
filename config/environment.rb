# Load the rails application
require File.expand_path('../application', __FILE__)

# Set the logger
Rails.logger = Logger.new(STDOUT)

# Initialize the rails application
Veggie::Application.initialize!
