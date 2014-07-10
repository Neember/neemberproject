class UpdateDefaultHoursSchedules < ActiveRecord::Migration
  def change
    change_table :schedules do |t|
      t.change :hours, :integer, default: 8
    end
  end
end
