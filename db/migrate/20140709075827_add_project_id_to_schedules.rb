class AddProjectIdToSchedules < ActiveRecord::Migration
  def change
    change_table :schedules do
      add_reference :schedules, :project, index: true
    end
  end
end
