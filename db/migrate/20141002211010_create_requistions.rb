class CreateRequistions < ActiveRecord::Migration
  def change
    create_table :requistions do |t|
      t.string :address
      t.string :status

      t.timestamps
    end
  end
end
