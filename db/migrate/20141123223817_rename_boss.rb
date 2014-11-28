class RenameBoss < ActiveRecord::Migration
  def change
  	rename_table :boss, :bosses
  	rename_column :bosses, :telephone, :phone
  end
end
