class AddUserIdToProjects < ActiveRecord::Migration
  def change
    change_table :projects do
      add_reference :projects, :user, index: true
    end
  end
end
