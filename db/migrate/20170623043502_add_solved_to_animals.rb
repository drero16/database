class AddSolvedToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :solved, :boolean
  end
end
