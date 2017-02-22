class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.text :title
      t.text :description
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :information, :users
  end
end
