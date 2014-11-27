class RenameRequistionContract < ActiveRecord::Migration
  def change
  	rename_column :requistions, :contract, :conract_id
  end
end
