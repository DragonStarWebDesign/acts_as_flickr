class ComplexPhoto < ActiveRecord::Base
  acts_as_flickr :flickr_identifier_field => :flickr_identifier, :flickr_url_field => :source,
                 :flickr_description_field => :body, :flickr_title_field => :name,
                 :connection_error_message => "We're sorry, but there was a problem with your upload."
end
