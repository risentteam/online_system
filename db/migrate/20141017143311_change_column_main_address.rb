class ChangeColumnMainAddress < ActiveRecord::Migration
  def change
  	change_column :buildings, :main_address, :integer
  end
end
