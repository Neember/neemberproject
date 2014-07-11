class RenameSchedulesToAbsences < ActiveRecord::Migration
  def change
    rename_table :schedules, :absences
  end
end
