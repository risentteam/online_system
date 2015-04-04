class CreateIndexes < ActiveRecord::Migration
  def change
    add_index :arrivals, :user_id
    add_index :arrivals, :building_id

    add_index :buildingscontracts, :building_id
    add_index :buildingscontracts, :contract_id

    add_index :contracts, :user_id

    add_index :pairs, :user_id
    add_index :pairs, :requistion_id

    add_index :requistions, :building_id
    add_index :requistions, :contract_id
  end
end
