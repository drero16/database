class AddAnimalStateToPets < ActiveRecord::Migration
  def change
    add_column :pets, :animal_state, :integer
  end
end
