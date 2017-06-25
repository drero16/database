class AddSolvedToPets < ActiveRecord::Migration
  def change
    add_column :pets, :solved, :boolean
  end
end
