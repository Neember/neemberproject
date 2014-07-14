class AddPivotalProjectIdToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.integer :pivotal_project_id, default: 0
    end
  end
end
