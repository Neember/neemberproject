class AddFieldsToClients < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.string :company_name
      t.string :title
      t.remove :name
      t.string :first_name
      t.string :last_name
      t.string :designation
    end
  end
end
