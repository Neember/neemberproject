class AddCoderIdToAbsences < ActiveRecord::Migration
  def change
    change_table :absences do
      add_reference :absences, :coder, index: true
    end
  end
end
