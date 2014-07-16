class UpdateDefaultVelocityProjects < ActiveRecord::Migration
  def change
    change_column :projects, :velocity, :integer, default: 10
  end
end
