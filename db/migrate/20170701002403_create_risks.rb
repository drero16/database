class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|
      t.string :animal_type
      t.string :sex
      t.text :location
      t.text :description
	  t.float :latitude
	  t.float :longitude
	  t.boolean :solved      
      t.belongs_to :user, index: true
      t.belongs_to :race, index: true

      t.timestamps null: false
    end
    add_foreign_key :risks, :users
    add_foreign_key :risks, :races
  end
end
