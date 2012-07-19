$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_flickr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_flickr"
  s.version     = ActsAsFlickr::VERSION
  s.authors     = ["DragonStar Web Design (Steve Aquino)"]
  s.email       = ["draco@dragonstarwebdesign.com"]
  s.homepage    = "TODO"
  s.summary     = "Allows ActiveRecord models to easily connect with Flickr API for photo hosting."
  s.description = "ActsAsFlickr is a simple ActiveRecord extension.  Just add acts_as_flickr to your " +
                  "model, add a flickr_id and url field to your model, and upload away!"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"
  s.add_dependency "flickraw", "~> 0.9.5"

  s.add_development_dependency "sqlite3"
end
