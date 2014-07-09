class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date :date
      t.integer :hours
      t.text :reason

      t.timestamps
    end
  end
end
