class RemoveRelativeToFieldFromRoles < ActiveRecord::Migration
  def change
    remove_column :roles, :relative_to, :string
  end
end
