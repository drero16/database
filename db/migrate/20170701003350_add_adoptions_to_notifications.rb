class AddAdoptionsToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :adoption, index: true
    add_foreign_key :notifications, :adoptions
  end
end
