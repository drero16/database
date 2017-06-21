class AddAnimalsToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :animal, index: true
    add_foreign_key :notifications, :animals
  end
end
