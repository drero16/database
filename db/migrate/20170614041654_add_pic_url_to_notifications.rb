class AddPicUrlToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :pic_url, :string
  end
end
