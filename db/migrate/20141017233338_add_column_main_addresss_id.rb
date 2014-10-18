class AddColumnMainAddresssId < ActiveRecord::Migration
  def change
    add_column :requistion, :main_address_id, :integer
  end
end
