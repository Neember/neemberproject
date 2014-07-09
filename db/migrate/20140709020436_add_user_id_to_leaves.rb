class AddUserIdToLeaves < ActiveRecord::Migration
  def change
    change_table :leaves do
      add_reference :leaves, :coder, index: true
    end
  end
end
