class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :relative_to

      t.timestamps
    end
  end
end
