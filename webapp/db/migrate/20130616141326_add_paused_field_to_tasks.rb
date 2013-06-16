class AddPausedFieldToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :paused, :boolean, default: false
  end
end
