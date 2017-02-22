class AddAttachmentImageToAnimals < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :animals, :image
  end
end
