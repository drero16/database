class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :animal_type
      t.integer :age
      t.string :sex
      t.text :location
      t.text :description
      t.belongs_to :user, index: true
      t.belongs_to :race, index: true

      t.timestamps null: false
    end
    add_foreign_key :animals, :users
    add_foreign_key :animals, :races
  end
end
