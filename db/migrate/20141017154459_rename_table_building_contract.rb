class RenameTableBuildingContract < ActiveRecord::Migration
  def change
  	rename_table :buildings_contracts, :buildingscontracts
  end
end
