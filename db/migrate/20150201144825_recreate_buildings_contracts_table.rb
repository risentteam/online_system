class RecreateBuildingsContractsTable < ActiveRecord::Migration
  def change
  	drop_table :buildingscontracts
  	create_table :buildingscontracts, force: true do |t|
      t.integer  "building_id",    null: false
      t.integer  "contract_id",    null: false
    end
  end
end
