class RenameRequistionContract2 < ActiveRecord::Migration
  def change
  	rename_column :requistions, :conract_id, :contract_id
  end
end
