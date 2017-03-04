class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :user_agent
      t.string :endpoint
      t.string :p256dh
      t.string :auth
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :devices, :users
  end
end
