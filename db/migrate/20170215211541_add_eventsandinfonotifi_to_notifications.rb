class AddEventsandinfonotifiToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :information, index: true
    add_foreign_key :notifications, :information
    add_reference :notifications, :event, index: true
    add_foreign_key :notifications, :events
  end
end
