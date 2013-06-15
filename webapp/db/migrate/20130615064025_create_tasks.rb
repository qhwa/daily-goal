class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :role_id

      t.timestamps
    end
    add_index :tasks, :role_id
  end
end
