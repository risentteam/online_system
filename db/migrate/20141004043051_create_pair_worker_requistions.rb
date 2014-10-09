class CreatePairWorkerRequistions < ActiveRecord::Migration
  def change
    create_table :pair_worker_requistions do |t|
      t.integer :id_worker
      t.integer :id_requistion

      t.timestamps
    end
  end
end
