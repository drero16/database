class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :description
      t.boolean :seen
      t.belongs_to :comment, index: true

      t.timestamps null: false
    end
    add_foreign_key :notifications, :comments
  end
end
