class AddRisksToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :risk, index: true
    add_foreign_key :notifications, :risks
  end
end
