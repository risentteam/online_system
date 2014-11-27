class ChangeColumnMainAddress < ActiveRecord::Migration
  def change
  	change_column :buildings, :main_address, :string
  end
end
