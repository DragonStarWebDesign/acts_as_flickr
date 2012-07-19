class CreateFlickrPhotos < ActiveRecord::Migration
  def change
    create_table :flickr_photos do |t|
      t.string :title
      t.string :description
      t.string :flickr_id
      t.string :url

      t.timestamps
    end
  end
end
