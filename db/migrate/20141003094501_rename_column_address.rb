class RenameColumnAddress < ActiveRecord::Migration
  def change
    rename_column :requistions, :main_address, :main_address
  end
end
