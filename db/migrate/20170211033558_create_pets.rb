class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :animal_type
      t.string :sex
      t.string :name
      t.integer :age      
      t.text :description
      t.date :lost_on
      t.text :lost_in
      t.belongs_to :user, index: true
      t.belongs_to :race, index: true

      t.timestamps null: false
    end
    add_foreign_key :pets, :users
    add_foreign_key :pets, :races
  end
end
