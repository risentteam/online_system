class ChangeType < ActiveRecord::Migration
  def change
    change_column :requistions, :type, :string
    rename_column :requistions, :type, :type_requistion
  end
end
