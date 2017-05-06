class AddAnimalStateToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :animal_state, :integer
  end
end
