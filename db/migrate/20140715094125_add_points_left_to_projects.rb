class AddPointsLeftToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.integer :points_left, default: 0
    end
  end
end
