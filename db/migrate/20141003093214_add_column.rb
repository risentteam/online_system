class AddColumn < ActiveRecord::Migration
  def change
    rename_column :requistions, :address, :object
    add_column :requistion, :main_address, :string
    add_column :requistion, :arrival_address, :string
    add column :requistion, :contact_name, :string
    add_column :requistion, :contact_phone, :string
  end
end
