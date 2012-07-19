# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

def flickr_login
  FlickRaw.api_key = "4cf04181f771ce4e45991df6e35e0da5"
  FlickRaw.shared_secret = "2cebe73834039c25"
  flickr.access_token = "72157630655400596-6cecba465a921b5b"
  flickr.access_secret = "7786bd521a39c446"
  flickr.test.login
end

def flickr_logout
  flickr.access_token = flickr.access_secret = nil
end

def test_image_file
  fixture_path = self.class.fixture_path if self.class.respond_to?(:fixture_path)
  Rack::Test::UploadedFile.new("#{fixture_path}/rails.png", 'image/png', false)
end

