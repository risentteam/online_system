class AddColumnRequistion < ActiveRecord::Migration
  def change
  	add_column :requistions, :buildings_id, :integer
  end
end
