class RanameTableMainAddress < ActiveRecord::Migration
  def change
  	rename_table :table_main_addresses, :main_address
  end
end
