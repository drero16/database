class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :titulo
      t.text :mensaje
      t.string :url
      t.boolean :seen
      t.belongs_to :user, index: true
    end
    add_foreign_key :notifications, :users
  end
end
