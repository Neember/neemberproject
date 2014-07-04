class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :domain
      t.float :no_of_sprints
      t.integer :price_per_sprint
      t.string :quotation_no
      t.date :date_started
      t.text :notes

      t.timestamps
    end
  end
end
