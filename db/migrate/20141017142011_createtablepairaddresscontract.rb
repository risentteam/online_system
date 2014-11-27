class Createtablepairaddresscontract < ActiveRecord::Migration
  def change
  	create_join_table :contracts, :buildings
  end
end
