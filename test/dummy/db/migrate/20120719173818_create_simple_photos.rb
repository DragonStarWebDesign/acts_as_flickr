class CreateSimplePhotos < ActiveRecord::Migration
  def change
    create_table :simple_photos do |t|
      t.string :flickr_id
      t.string :url

      t.timestamps
    end
  end
end
