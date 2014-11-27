class AddColumnRequistionAddIdAddress < ActiveRecord::Migration
  def change
    add_column :requistions, :building_id, :integer
  end
end
