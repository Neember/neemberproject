class AddClientIdToProjects < ActiveRecord::Migration
  def change
    change_table :projects do
      add_reference :projects, :client, index: true
    end
  end
end
