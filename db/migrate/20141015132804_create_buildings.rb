class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :main_address
      t.string :arrival_address
      t.string :status
      t.string :linkQR

      t.timestamps
    end
  end
end
