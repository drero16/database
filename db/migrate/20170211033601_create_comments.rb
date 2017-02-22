class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :description
      t.belongs_to :animal, index: true
      t.belongs_to :pet, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :animals
    add_foreign_key :comments, :pets
    add_foreign_key :comments, :users
  end
end
