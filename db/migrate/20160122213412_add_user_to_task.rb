class AddUserToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :user, :integer
  end
end
