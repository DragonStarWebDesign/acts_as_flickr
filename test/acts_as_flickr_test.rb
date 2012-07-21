# ToDo: finish test suite by adding tests for ComplexPhoto and SimplePhoto

require 'test_helper'

class ActsAsFlickrTest < ActiveSupport::TestCase
  fixtures :flickr_photos

  def setup
    flickr_login
  end

  test "ActsAsFlickr models should have flickr fields" do
    assert_equal "flickr_id", FlickrPhoto.flickr_identifier_field
    assert_equal "url", FlickrPhoto.flickr_url_field
    assert_equal "title", FlickrPhoto.flickr_title_field
    assert_equal "description", FlickrPhoto.flickr_description_field
    assert_nil FlickrPhoto.new.image_file
  end

  test "should be able to pass custom flickr fields" do
    assert_equal "flickr_identifier", ComplexPhoto.flickr_identifier_field
    assert_equal "source", ComplexPhoto.flickr_url_field
    assert_equal "name", ComplexPhoto.flickr_title_field
    assert_equal "body", ComplexPhoto.flickr_description_field
  end

  test "should check if connected to Flickr" do
    assert_not_nil FlickrPhoto.connected_to_flickr?
  end

  test "ActsAsFlickr models should have as_flickr_upload" do
    photo = flickr_photos(:one)
    assert_not_nil photo.as_flickr_upload
    assert_equal "Test", photo.as_flickr_upload[:title]
    assert_equal "This is a test", photo.as_flickr_upload[:description]
  end

  test "should connect to Flickr when creating a new ActsAsFlickr model" do
    photo = FlickrPhoto.new(:title => "Test", :description => "This is a test", :image_file => test_image_file)
    assert photo.save, photo.errors.full_messages.join(", ")
    assert_not_nil photo.flickr_id
    assert_not_nil photo.url
    assert_match "flickr.com", photo.url
  end

  test "should add errors when not connected to Flickr" do
    flickr_logout
    photo = FlickrPhoto.create(:title => "Test", :description => "This is a test", :image_file => test_image_file)
    assert_equal photo.errors[:base].first, "You must be connected to Flickr first (see https://github.com/hanklords/flickraw#authentication)"
  end
end
