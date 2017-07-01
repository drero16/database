class CreateAdoptions < ActiveRecord::Migration
  def change
    create_table :adoptions do |t|
      t.string :animal_type
      t.string :sex
      t.string :name
      t.text :description
      t.integer :age      
      t.date :lost_on
      t.text :lost_in
	  t.float :latitude
	  t.float :longitude
	  t.boolean :solved       
      t.belongs_to :user, index: true
      t.belongs_to :race, index: true

      t.timestamps null: false
    end
    add_foreign_key :adoptions, :users
    add_foreign_key :adoptions, :races
  end
end
