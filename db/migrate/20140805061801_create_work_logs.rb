class CreateWorkLogs < ActiveRecord::Migration
  def change
    create_table :work_logs do |t|
      t.date :date
      t.integer :hours, default: 8
      t.string :status
      t.text :reason
      t.references :project
      t.references :coder

      t.timestamps
    end
  end
end
