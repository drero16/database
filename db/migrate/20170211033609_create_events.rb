class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :title
      t.text :description
      t.date :date_event
      t.text :location
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :events, :users
  end
end
