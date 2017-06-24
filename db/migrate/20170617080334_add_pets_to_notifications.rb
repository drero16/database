class AddPetsToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :pet, index: true
    add_foreign_key :notifications, :pets
  end
end
