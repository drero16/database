class AddCommentsToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :comment, index: true
    add_foreign_key :notifications, :comments
  end
end
