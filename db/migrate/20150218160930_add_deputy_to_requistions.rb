class AddDeputyToRequistions < ActiveRecord::Migration
  def change
  	add_column :requistions, :deputy, :string
  end
end
