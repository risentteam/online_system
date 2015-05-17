class AddNameWithoutSpecialSymbol < ActiveRecord::Migration
  def change
   	add_column :buildings, :address_without_special_symbol, :string 	
  end
end
	