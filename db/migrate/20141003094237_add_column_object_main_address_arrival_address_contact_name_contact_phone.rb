class AddColumnObjectMainAddressArrivalAddressContactNameContactPhone < ActiveRecord::Migration
  def change
    rename_column :requistions, :address, :object
    add_column :requistions, :main_address, :string
    add_column :requistions, :arrival_address, :string
    add_column :requistions, :contact_name, :string
    add_column :requistions, :contact_phone, :string
  end
end
