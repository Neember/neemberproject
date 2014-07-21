class AddRepoToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.string :repository
    end
  end
end
