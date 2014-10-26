class AddColumnMainAddresssId < ActiveRecord::Migration
  def change
    add_column :requistions, :main_address_id, :integer
  end
end
