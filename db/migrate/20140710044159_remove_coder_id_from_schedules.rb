class RemoveCoderIdFromSchedules < ActiveRecord::Migration
  def change
    remove_reference :schedules, :coder, index: true
  end
end
