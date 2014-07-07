class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :coders_projects do |t|
      t.references :project
      t.references :coder
    end
  end
end
