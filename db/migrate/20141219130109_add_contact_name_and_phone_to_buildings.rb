class AddContactNameAndPhoneToBuildings < ActiveRecord::Migration
  def change
  	add_column :buildings, :contact_phone, :string
  	add_column :buildings, :contact_name, :string
  end
end
