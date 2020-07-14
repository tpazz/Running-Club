class AddAttachmentPhotoToGalleries < ActiveRecord::Migration[5.2]
  def self.up
    change_table :galleries do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :galleries, :photo
  end
end
