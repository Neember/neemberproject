class AddCoderIdToSchedules < ActiveRecord::Migration
  def change
    change_table :schedules do
      add_reference :schedules, :coder, index: true
    end
  end
end
