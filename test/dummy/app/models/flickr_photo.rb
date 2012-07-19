class FlickrPhoto < ActiveRecord::Base
  attr_accessible :description, :title, :image_file
  acts_as_flickr
  before_create :upload_to_flickr
  before_create :upload_to_flickr
end
