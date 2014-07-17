class AddDateCompletedToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.date :date_completed
    end
  end
end
