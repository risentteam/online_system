class RemoveUnnecessaryColumns < ActiveRecord::Migration
  def change
  	remove_columns :buildings, :main_address, :main_address_id, :linkQR
  end
end
