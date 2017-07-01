class AddEventsToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :event, index: true
    add_foreign_key :notifications, :events
  end
end
