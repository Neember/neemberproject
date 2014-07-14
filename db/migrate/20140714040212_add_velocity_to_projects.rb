class AddVelocityToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.integer :velocity, default: 0
    end
  end
end
