module ActsAsFlickr
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def acts_as_flickr(options = {})
      cattr_accessor :flickr_identifier_field
      cattr_accessor :flickr_url_field
      cattr_accessor :flickr_title_field
      cattr_accessor :flickr_description_field
      cattr_accessor :flickr_connection_error_message

      self.flickr_identifier_field = (options[:flickr_identifier_field] || :flickr_id).to_s
      self.flickr_url_field = (options[:flickr_url_field] || :url).to_s
      self.flickr_title_field = (options[:flickr_title_field] || :title).to_s
      self.flickr_description_field = (options[:flickr_description_field] || :description).to_s

      default_connect_message = "You must be connected to Flickr first (see https://github.com/hanklords/flickraw#authentication)"
      self.flickr_connection_error_message = (options[:connection_error_message] || default_connect_message).to_s

      attr_accessor :image_file
    end

    def connected_to_flickr?
      try(:flickr) && flickr.access_token.present? && flickr.access_secret.present?
    end
  end

  def as_flickr_upload
    {:title => self.send( self.class.flickr_title_field ), :description => self.send( self.class.flickr_description_field )}
  end

  private

    def add_connection_error
      self.errors.add(:base, self.class.flickr_connection_error_message)
    end

    def upload_to_flickr
      if self.class.connected_to_flickr?
        self.send( "#{self.class.flickr_identifier_field}=", flickr.upload_photo(self.image_file.path, self.as_flickr_upload) ) and
        self.send( "#{self.class.flickr_url_field}=", FlickRaw.url_b( flickr.photos.getInfo(photo_id: self.flickr_id) ) )
      else
        add_connection_error and return false
      end
    end

    def update_flickr
      if self.class.connected_to_flickr?
        flickr.photos.setMeta photo_id: self.send( self.class.flickr_title_field ).merge(self.as_flickr_upload)
      else
        add_connection_error and return false
      end
    end

    def remove_from_flickr
      flickr.photos.delete photo_id: self.send( self.class.flickr_title_field ) if self.class.connected_to_flickr?
    end

end

ActiveRecord::Base.send :include, ActsAsFlickr
