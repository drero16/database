class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :link
      t.belongs_to :animal, index: true
      t.belongs_to :pet, index: true
      t.belongs_to :event, index: true
      t.belongs_to :information, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :images, :animals
    add_foreign_key :images, :pets
    add_foreign_key :images, :events
    add_foreign_key :images, :information
    add_foreign_key :images, :users
  end
end
