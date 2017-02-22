class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :sex
      t.belongs_to :role, index: true

      t.timestamps null: false
    end
    add_foreign_key :users, :roles
  end
end
