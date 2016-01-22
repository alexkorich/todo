class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :project_id
      t.integer :position
      t.datetime :deadline
      t.boolean :done

      t.timestamps null: false
    end
  end
end
