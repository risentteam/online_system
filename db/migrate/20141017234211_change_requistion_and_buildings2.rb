class ChangeRequistionAndBuildings2 < ActiveRecord::Migration
  def change
    add_column :buildings, :main_address_id, :integer
    remove_column :requistions, :main_address_id, :integer
  end
end
