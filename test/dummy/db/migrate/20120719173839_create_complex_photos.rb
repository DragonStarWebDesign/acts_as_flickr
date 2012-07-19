class CreateComplexPhotos < ActiveRecord::Migration
  def change
    create_table :complex_photos do |t|
      t.string :flickr_identifier
      t.string :source
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
