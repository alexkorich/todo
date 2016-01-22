class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :author
      t.string :attach

      t.timestamps null: false
    end
  end
end
