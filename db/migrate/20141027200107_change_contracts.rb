class ChangeContracts < ActiveRecord::Migration
  def change
  	add_column :contracts, :comment, :string
  	add_column :contracts, :description, :string
  	add_column :contracts, :name_contract, :string
  	rename_column :contracts, :period_contract, :date_of_signing
  	add_column :contracts, :period, :string 
  end
end
